class ResetAllDestinationsCacheCounters < ActiveRecord::Migration[7.1]
  
  def up
    Destination.all.each do |destination|
      Destination.reset_counters(destination.id, :dive_centers)
      Destination.reset_counters(destination.id, :dive_sites)
    end
  end
  
  def down
    
  end
  
end
