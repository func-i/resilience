class RegistrationInvitationsController < ApplicationController
  respond_to :html
  before_action :authenticate_user!

  def new
    @registration_invitation = current_user.
      registration_invitations.build

    respond_with @registration_invitation
  end

  def create
    @registration_invitation = current_user.
      registration_invitations.build create_params

    if @registration_invitation.save
      RegistrationInvitationMailer.invite(@registration_invitation).deliver

      flash[:notice] = t('controllers.registration_invitations.create.notice',
        email: params[:registration_invitation][:recipient_email]) \
    end

    respond_with @registration_invitation,
      location: new_registration_invitation_path
  end

  private

  def create_params
    params.require(:registration_invitation).
      permit(:recipient_email)
  end
end
