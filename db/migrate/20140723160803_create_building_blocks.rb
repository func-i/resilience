class CreateBuildingBlocks < ActiveRecord::Migration
  def change
    create_table :building_blocks do |t|
      t.string :title
      t.references :owner, index: true
      t.string :state

      t.timestamps
    end
  end
end
