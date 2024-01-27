class CreateCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.text :description
      t.float :latitude
      t.float :longitude
      t.text :bounding_box, array: true, default: []
      
      t.string :code
      t.text :languages, array: true, default: []
      t.string :demonym
      t.string :currency
      t.string :pressure
      t.string :phone_prefix
      t.string :voltage
      t.string :plug
      t.string :international_airports, array: true, default: []
      
      t.integer :dive_centers_count, default: 0
      t.integer :dive_sites_count, default: 0
      t.integer :regions_count, default: 0
      t.integer :cities, default: 0
      
      t.references :geo_group, foreign_key: true

      t.timestamps
    end
  end
end
