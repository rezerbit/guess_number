class CreateSecretnumbers < ActiveRecord::Migration
  def change
    create_table :secretnumbers do |t|
      t.integer :value
      t.integer :user_id

      t.timestamps
    end
  end
end
