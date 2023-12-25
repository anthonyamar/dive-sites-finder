class AddCounterChachesToDestination < ActiveRecord::Migration[7.1]
  def change
    
    add_column :destinations, :dive_centers_count, :integer, default: 0
    add_column :destinations, :dive_sites_count, :integer, default: 0
  end
end
