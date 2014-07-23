class CreateBuildingBlocks < ActiveRecord::Migration
  def change
    create_table :building_blocks do |t|
      t.string :title
      t.references :owner, index: true
      t.string :workflow_state

      t.timestamps
    end

    add_index :building_blocks, :workflow_state
  end
end
