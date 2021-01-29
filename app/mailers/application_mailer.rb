# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'zakaria@sandbox2ae674dd0e404c9fb4bf66baffc5daf9.mailgun.org'
  layout 'mailer'
end
