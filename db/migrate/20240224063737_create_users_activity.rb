class CreateUsersActivity < ActiveRecord::Migration[7.1]
  def change
    create_table :users_activities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true
      
      t.timestamps
    end
    
    add_column :activities, :users_count, :integer, default: 0
  end
end
