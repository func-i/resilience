class User < ActiveRecord::Base
  include UserPhoto
  rolify before_add: :permit_role

  before_save :ensure_role_presence

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :registerable,
    :rememberable, :trackable, :validatable

  validates :name, :organization,
    presence: true, allow_blank: false

  validates_associated :roles

  has_one  :registration_invitation, foreign_key: :recipient_id
  has_many :registration_invitations, foreign_key: :sender_id
  has_many :building_blocks, foreign_key: :owner_id

  private

  def ensure_role_presence
    add_role(Role::DEFAULT_ROLE) if role_ids.blank?
  end

  def permit_role role
    unless Role::ALLOWED_ROLES.include?(role.name)
      errors.add(:roles, "Role #{role.name} is not allowed")
      self.role_ids.delete(role.id)
    end
  end
end
