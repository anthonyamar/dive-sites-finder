class RemoveCountryAndRegionColumnFromDiveTables < ActiveRecord::Migration[7.1]
  def change
    remove_column :dive_sites, :country
    remove_column :dive_sites, :region
    
    remove_column :dive_centers, :city
  end
end
