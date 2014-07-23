class BuildingBlock < ActiveRecord::Base
  belongs_to :owner,
    class_name: User,
    inverse_of: :building_blocks

  has_many :attachments, as: :attachable

  validates :title, presence: true
end
