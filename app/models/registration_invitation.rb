class RegistrationInvitation < ActiveRecord::Base
  EXPIRE_PERIOD = 2.days

  before_create :invitation_token!

  belongs_to :sender, class_name: User
  belongs_to :recipient, class_name: User

  validates :recipient_email, presence: true, email: true
  validate :recipient_persistence

  def expired?
    Time.now > created_at + EXPIRE_PERIOD
  end

  private

  def recipient_persistence
    recipient = User.find_by(email: self.recipient_email)

    if recipient.present?
      self.errors.add :recipient_email,
       I18n::t('validators.registration_invitation.email.persist')
    end
  end

  def invitation_token!
    self.invitation_token = SecureRandom.base64(12)
  end

end
