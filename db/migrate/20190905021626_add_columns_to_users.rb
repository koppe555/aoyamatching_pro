class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :campus, :string
    add_column :users, :faculty, :string
    add_column :users, :grade, :integer
    add_column :users, :introduction, :string
    add_column :users, :admin, :boolean
  end
end
