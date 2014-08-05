class AddPhotoToUser < ActiveRecord::Migration
  def change
    add_column :users, :photo_name, :string
    add_column :users, :photo_uid, :string
    add_index :users, :photo_uid
  end
end
