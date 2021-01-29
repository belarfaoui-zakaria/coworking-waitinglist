class RequestMailer < ApplicationMailer
  def confirm_email
    @request = params[:request]
    mail(to: @request.freelancer.email, subject: 'Coworking space – Confirmation de votre adresse e-mail')
  end

  def reconfirm_request
    @request = params[:request]
    mail(to: @request.freelancer.email, subject: "Coworking space – Votre demande d'inscription expire prochainement")
  end
end
