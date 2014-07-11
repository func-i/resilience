class User < ActiveRecord::Base
  include UserPhoto

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
    :rememberable, :trackable, :validatable

  validates :name, :organization,
    presence: true, allow_blank: false

end
