class AddDetailsToPictures < ActiveRecord::Migration[6.1]
  def change
    add_column :pictures, :name, :string
    add_column :pictures, :email, :string
  end
end
