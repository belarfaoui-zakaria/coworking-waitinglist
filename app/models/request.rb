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
    state :confirmed, :accepted

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

    # event :sleep do
    #   transitions from: [:running, :cleaning], to: :sleeping
    # end
  end

  def accept!
    accept
    save
  end

  def confirm!
    confirm
    regenerate_confirmation_token
  end

  private

  def on_request_confirmed
    self.confirmed_at = DateTime.now
  end

  def on_request_accepted
    self.accepted_at = DateTime.now
  end
end
