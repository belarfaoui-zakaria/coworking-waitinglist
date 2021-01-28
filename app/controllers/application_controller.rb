# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ConfirmationError, with: :confirmation_failed

  def confirmation_failed(error)
    render 'requests/confirmation_failed', statue: error.status
  end
end
