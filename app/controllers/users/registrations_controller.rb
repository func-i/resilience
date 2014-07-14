class Users::RegistrationsController < Devise::RegistrationsController
  before_action :validate_invitation, only: [:new, :create]
  after_action :accept_invitation, only: [:create]

  def new
    super
  end

  def create
    configure_permitted_parameters
    super
  end

  def edit
    redirect_to root_path, notice: 'You are not invited'
  end


  def update
    redirect_to root_path, alert: 'Not allowed'
  end

  def destroy
    redirect_to root_path, alert: 'Not allowed'
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :organization, :phone, :website]
  end

  private

  def validate_invitation
    if invitation.blank?
      redirect_to root_path, notice: "Not exists" and return
    else
      redirect_to root_path, notice: "Invitation link was expired" and return \
        if invitation.expired?

      redirect_to root_path, notice: "Invitation was allredy accepted" and return \
        if invitation.recipient.present?
    end
  end

  def accept_invitation
    invitation.recipient = resource
    invitation.save if resource.present?
  end

  def invitation
    @invitation ||= RegistrationInvitation.find_by(invitation_token: params[:invitation_token])
  end
end
