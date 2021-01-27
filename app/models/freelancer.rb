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

  has_one :request

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true, format: EMAIL_REGEX
  validates :biography, presence: true

end
