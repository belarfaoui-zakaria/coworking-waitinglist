class RequestMailer < ApplicationMailer
  def confirm_email
    @request = params[:request]
    mail(to: @request.freelancer.email, subject: 'Coworking space – Confirmation de votre adresse e-mail')
  end

  def reconfirm_request(request:)
    @request = request
    mail(to: @request.freelancer.email, subject: 'Votre demande pour rejoindre Coworking space')
  end
end
