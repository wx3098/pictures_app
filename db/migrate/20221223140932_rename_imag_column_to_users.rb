class RenameImagColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :imag, :image
  end
end
