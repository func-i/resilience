class User < ActiveRecord::Base
  rolify
  include UserPhoto

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :registerable,
    :rememberable, :trackable, :validatable

  validates :name, :organization,
    presence: true, allow_blank: false

  has_one  :registration_invitation, foreign_key: :recipient_id
  has_many :registration_invitations, foreign_key: :sender_id
end
