class Users::RegistrationsController < Devise::RegistrationsController
  before_action :validate_invitation, only: [:new, :create]
  after_action :accept_invitation, only: [:create]

  def create
    permitted_parameters
    super
  end

  def edit
    not_allowed_action!
  end


  def update
    not_allowed_action!
  end

  def destroy
    not_allowed_action!
  end

  protected

  def permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :organization, :phone, :website]
  end

  private

  def validate_invitation
    if invitation.blank?
      redirect_to root_path, alert: t('controllers.registrations.validate_invitation.not_found') and return
    else
      redirect_to root_path, alert: t('controllers.registrations.validate_invitation.expired') and return \
        if invitation.expired?

      redirect_to root_path, alert: t('controllers.registrations.validate_invitation.accepted') and return \
        if invitation.accepted?
    end
  end

  def accept_invitation
    invitation.recipient = resource
    invitation.save if resource.present?
  end

  def invitation
    @invitation ||= RegistrationInvitation.find_by(invitation_token: params[:invitation_token])
  end

  def not_allowed_action!
    redirect_to root_path, notice: 'Not allowed'
  end
end
