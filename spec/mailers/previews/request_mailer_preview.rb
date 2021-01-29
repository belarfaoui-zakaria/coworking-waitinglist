# Preview all emails at http://localhost:3000/rails/mailers/request_mailer
class RequestMailerPreview < ActionMailer::Preview
  def confirmation_email
    RequestMailer.with(request: Request.last).reconfirm_request
  end
end
