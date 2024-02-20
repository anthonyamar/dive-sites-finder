class CreateDiveCentersActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :dive_centers_activities do |t|
      t.references :dive_center, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
