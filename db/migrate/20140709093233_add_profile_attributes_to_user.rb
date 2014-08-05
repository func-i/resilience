class AddProfileAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :title, :string
    add_column :users, :organization, :string
    add_column :users, :phone, :string
    add_column :users, :website, :string
  end
end
