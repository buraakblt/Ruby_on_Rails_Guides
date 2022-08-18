class AddViewsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :views, :integer
  end
end
