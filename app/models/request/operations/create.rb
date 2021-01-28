# frozen_string_literal: true

class Request::Operations::Create
  include Request::Operations::Service

  def call(params:, **)
    @ctx[:model] = Request.new(freelancer: Freelancer.new(params))
    if @ctx[:model].save
      @success = true
    else
      errors = []
      errors << @ctx[:model]&.errors&.full_messages
      errors << @ctx[:model]&.freelancer&.errors&.full_messages
      @ctx[:errors] = errors.dup.flatten
    end
  end
end
