# frozen_string_literal: true

class Request::Operations::Confirm
  include Request::Operations::Service

  def call(params:, **)
    @ctx[:model] = Request.find(params[:token])
    @ctx[:model].confirm!
  rescue RecordNotFound
    raise ConfirmationError
  end
end
