class AddUserIdToTheArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :user_id, :int
    # remove_column :articles, :used_id
  end
end
