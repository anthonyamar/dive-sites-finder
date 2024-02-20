class AddVisibleStateToJointTablesActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :dive_centers_activities, :visible, :boolean, default: true
  end
end
