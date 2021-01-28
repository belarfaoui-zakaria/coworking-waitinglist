# frozen_string_literal: true

class Request::Operations::Expire
  include Request::Operations::Service

  def call(request:, **)
    @ctx[:model] = request.respond_to?(:id) ? request : Request.find(request)
    @ctx[:model].confirm!
  rescue RecordNotFound
    raise ConfirmationError
  end
end
