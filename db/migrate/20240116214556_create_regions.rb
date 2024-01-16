class CreateRegions < ActiveRecord::Migration[7.1]
  def change
    create_table :regions do |t|
      t.string :name, null: false
      t.text :description
      t.float :latitude
      t.float :longitude
      t.text :bounding_box, array: true, default: []
      
      t.integer :dive_centers_count, default: 0
      t.integer :dive_sites_count, default: 0
      t.integer :cities, default: 0
      
      t.references :country, foreign_key: true
      
      t.timestamps
    end
  end
end
