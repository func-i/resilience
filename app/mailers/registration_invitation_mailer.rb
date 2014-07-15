class RegistrationInvitationMailer < ActionMailer::Base
  default from: "invitaitons@herokuapp.com"

  def invite registration_invitation_id
    @registration_invitation = RegistrationInvitation.includes(:sender).find(registration_invitation_id)
    @sender = @registration_invitation.sender
    @recipient_email = @registration_invitation.recipient_email

    mail(to: @recipient_email, subject: "#{@sender.name} invites you to join Resilience Project")
  end
end
