# frozen_string_literal: true

class ConfirmationError < StandardError
  attr_reader :status, :message

  def initialize
    @status = :unprocessable_entity
    @message = 'token provided is not valid'
  end
end
