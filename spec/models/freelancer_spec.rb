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
    it { should have_one(:request) }
  end

  describe 'validations' do
    let(:freelancer) { create(:freelancer) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:biography) }

    it 'is expected to have a valid email' do
      invalid_emails = ['rex', 'test user@example.com', 'test_user@example server.com']
      invalid_emails.each do |email|
        freelancer.email = email
        expect(freelancer).to_not be_valid
      end
    end
  end
end
