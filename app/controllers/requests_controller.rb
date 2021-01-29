# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :resolve_request_token, only: %i[confirm reconfirm]
  def new
    @request = Request.new
    # @freelancer = Freelancer.new
  end

  def create
    @request = Request.new
    @request.freelancer = Freelancer.new(request_params)
    if @request.save
      RequestMailer.with(request: @request).confirm_email.deliver_later
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirm
    @request.confirm!
  end

  def reconfirm
    @request.reconfirm!
  end

  private

  def request_params
    params.require(:request).require(:freelancer).permit(:biography, :name, :email, :phone_number)
  end

  def resolve_request_token
    @request = Request.find_by(confirmation_token: params[:token])
    raise ConfirmationError if @request.nil?
  end
end
