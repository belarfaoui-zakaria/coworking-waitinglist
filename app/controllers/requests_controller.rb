# frozen_string_literal: true

class RequestsController < ApplicationController
  def new
    @request = Request.new
    # @freelancer = Freelancer.new
  end

  def create
    ctx = Request::Operations::Create.call(params: request_params)
    if ctx.success?
      RequestMailer.with(request: ctx[:model]).confirm_email.deliver_later
      render json: ctx[:model], status: :ok
    else
      render json: ctx[:errors], status: :unprocessable_entity
    end
  end

  def confirmation
    # @request = Request.find_by()
  end

  private

  def request_params
    params.require(:request).require(:freelancer).permit(:biography, :name, :email, :phone_number)
  end
end
