class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.string :name, null: false
      t.text :description
      t.float :latitude
      t.float :longitude
      t.text :bounding_box, array: true, default: []
      
      t.string :timezone
      t.boolean :capital_city
      
      t.integer :dive_centers_count, default: 0
      t.integer :dive_sites_count, default: 0
      
      t.references :region, foreign_key: true
      
      t.timestamps
    end
  end
end
