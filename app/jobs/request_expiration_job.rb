class RequestExpirationJob < ApplicationJob
  queue_as :default

  def perform(request_id:)
    @request = Request.find(request_id)
    return unless @request

    @request.expire! if !@request.accepted? && @request.will_expire_at <= DateTime.now
  end
end
