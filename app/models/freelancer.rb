# frozen_string_literal: true

# == Schema Information
#
# Table name: freelancers
#
#  id           :integer          not null, primary key
#  biography    :text
#  name         :string
#  phone_number :string
#  email        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Freelancer < ApplicationRecord
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/.freeze

  has_one :request, dependent: :destroy, inverse_of: :freelancer

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true, format: EMAIL_REGEX
  validates :biography, presence: true
  validate :freelancer_has_already_request

  def freelancer_has_already_request
    request_exists = Request.joins(:freelancer).where('state != ? and lower(email) = ?', 'expired', email.downcase).exists?
    errors.add(:have_existing_request, 'A request is already sent by this freelancer') if request_exists
  end
end
