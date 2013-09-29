class AddIndexToSecretnumbersUserId < ActiveRecord::Migration
  def change
    add_index :secretnumbers, :user_id
  end
end
