require 'rails_helper'

RSpec.describe RequestExpirationJob, type: :job do
  let(:request) { create(:request) }
  # let(:request_to_expire) { create(:request_with_expiration) }
  let(:subject) { described_class.perform_now(request_id: request.id) }

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  describe 'confirm!' do
    it 'runs 2 jobs' do
      expect { request.confirm! }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(2)
    end
  end

  describe 'non expired request' do
    it 'changes state to expired' do
      request.confirm!
      described_class.perform_now(request_id: request.id)
      request.reload
      expect(request.state).not_to eq('expired')
    end
  end

  describe 'expired request' do
    let(:request) { create(:request, :expired) }

    it 'changes state to expired' do
      described_class.perform_now(request_id: request.id)
      request.reload
      expect(request.state).to eq('expired')
    end
  end
end
