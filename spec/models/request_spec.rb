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
require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:subject) { create(:request) }
  let(:invalid_freelancer) { Freelancer.new }

  describe 'associations' do
    it { is_expected.to belong_to(:freelancer) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:freelancer) }

    it "souldn't be valid with invalid freelancer" do
      subject.freelancer = invalid_freelancer
      expect(subject).not_to be_valid
    end
  end

  describe 'request creation' do
    it 'has state unconfirmed' do
      expect(subject.state).to eq('unconfirmed')
    end

    it 'has a confirmation token' do
      expect(subject.confirmation_token).to be_present
    end
  end

  describe 'request confirmation' do
    it 'changes state to confirmed' do
      subject.confirm!
      expect(subject.state).to eq('confirmed')
      expect(subject.confirmed_at).not_to be_nil
    end
  end

  describe 'request acceptance' do
    it 'is invalid transition' do
      expect do
        subject.accept!
      end.to raise_error(AASM::InvalidTransition)
    end

    it 'accepts request' do
      subject.confirm
      subject.accept!
      expect(subject.state).to eq('accepted')
      expect(subject.accepted_at).not_to be_nil
    end
  end
end
