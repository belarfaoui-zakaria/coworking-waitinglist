# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@coworking.test'
  layout 'mailer'
end
