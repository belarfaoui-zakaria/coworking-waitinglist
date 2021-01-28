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
require 'rails_helper'

RSpec.describe Freelancer, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:request) }
  end

  describe 'validations' do
    let(:freelancer) { create(:freelancer) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:biography) }

    it 'is expected to have a valid email' do
      invalid_emails = ['rex', 'test user@example.com', 'test_user@example server.com']
      invalid_emails.each do |email|
        freelancer.email = email
        expect(freelancer).not_to be_valid
      end
    end
  end
end
