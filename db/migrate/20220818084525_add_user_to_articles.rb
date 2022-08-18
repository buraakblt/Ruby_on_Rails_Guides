class AddUserToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :user, null: false, foreign_key: true
  end
end
