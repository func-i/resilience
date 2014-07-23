class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :title
      t.string :file_name
      t.string :file_uid
      t.references :attachable, polymorphic: true, index: true

      t.timestamps
    end

    add_index :attachments, :file_uid
  end
end
