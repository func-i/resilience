class BuildingBlock < ActiveRecord::Base
  include BuildingBlockStates

  searchkick settings: {number_of_shards: 1},
    word_start: [:title]


  belongs_to :owner,
    class_name: User,
    inverse_of: :building_blocks

  belongs_to :parent, class_name: BuildingBlock, inverse_of: :derivatives
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :derivatives, class_name: BuildingBlock, foreign_key: :parent_id
  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :title, presence: true

  def clone_with_new_owner new_owner
    new_building_block = dup
    if parent_id
      new_building_block.parent_id = parent_id
    else
      new_building_block.parent_id = id
    end

    new_building_block.owner = new_owner
    new_building_block
  end

  def search_data
    {
      owner_name: owner.name,
      owner_email: owner.email,
      organization: owner.organization
    }
  end
end
