class RenameCitiesToCitiesCount < ActiveRecord::Migration[7.1]
  def change
    rename_column :geo_groups, :cities, :cities_count
    rename_column :countries, :cities, :cities_count
    rename_column :regions, :cities, :cities_count
  end
end
