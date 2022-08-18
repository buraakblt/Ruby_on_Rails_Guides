class ChangeViewsForUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :views, :integer, default: 0
  end
end
