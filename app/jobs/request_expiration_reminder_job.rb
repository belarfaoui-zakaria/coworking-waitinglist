class RequestExpirationReminderJob < ApplicationJob
  queue_as :default

  def perform(request_id:)
    @request = Request.find(request_id)
    return unless @request

    RequestMailer.with(request: @request).reconfirm_request.deliver
  end
end
