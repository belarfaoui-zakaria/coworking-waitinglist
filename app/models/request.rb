# frozen_string_literal: true

# == Schema Information
#
# Table name: requests
#
#  id                 :integer          not null, primary key
#  confirmation_token :string
#  confirmed_at       :datetime
#  accepted_at        :datetime
#  will_expire_at     :datetime
#  expired_at         :datetime
#  freelancer_id      :integer
#  state              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Request < ApplicationRecord
  # this is rails method to generate a secure token
  has_secure_token :confirmation_token

  scope :unconfirmed, -> { joins(:freelancer).where(state: :unconfirmed).order(created_at: :asc) }
  scope :confirmed, -> { joins(:freelancer).where(state: :confirmed).order(confirmed_at: :asc) }
  scope :accepted, -> { joins(:freelancer).where(state: :accepted).order(accepted_at: :desc) }
  scope :expired, -> { joins(:freelancer).where(state: :expired) }

  belongs_to :freelancer, validate: true
  validates :freelancer, presence: true

  include AASM
  aasm :state do
    state :unconfirmed, initial: true
    state :confirmed, :accepted, :expired

    event :confirm do
      transitions from: :unconfirmed, to: :confirmed
      after do
        on_request_confirmed
      end
    end

    event :accept do
      transitions from: :confirmed, to: :accepted
      after do
        on_request_accepted
      end
    end

    event :expire do
      transitions from: %i[confirmed unconfirmed], to: :expired
      after do
        on_request_expired
      end
    end
  end

  def accept!
    accept
    save
  end

  def confirm!
    confirm
    regenerate_confirmation_token
    save
  end

  def reconfirm!
    self.will_expire_at += 3.months
    regenerate_confirmation_token
    create_expiration_reminder_jobs
    save
  end

  def expire!
    expire
    save
  end

  private

  def on_request_confirmed
    self.confirmed_at = DateTime.now
    self.will_expire_at = 3.months.from_now.to_date
    create_expiration_reminder_jobs
  end

  def on_request_accepted
    self.accepted_at = DateTime.now
  end

  def on_request_expired
    self.expired_at = DateTime.now
  end

  def create_expiration_reminder_jobs
    remind_at = will_expire_at - 1.week
    RequestExpirationReminderJob.set(wait_until: remind_at).perform_later(request_id: id)
    RequestExpirationJob.set(wait_until: will_expire_at).perform_later(request_id: id)
  end
end
