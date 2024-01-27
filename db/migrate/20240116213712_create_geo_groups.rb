class CreateGeoGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :geo_groups do |t|
      t.string :name, null: false
      t.text :description
      t.float :latitude
      t.float :longitude
      t.text :bounding_box, array: true, default: []
      
      t.integer :dive_centers_count, default: 0
      t.integer :dive_sites_count, default: 0
      t.integer :countries_count, default: 0
      t.integer :regions_count, default: 0
      t.integer :cities, default: 0
      
      t.timestamps
    end
  end
end
