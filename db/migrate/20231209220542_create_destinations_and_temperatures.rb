class CreateDestinationsAndTemperatures < ActiveRecord::Migration[7.1]
  def change
    create_table :destinations do |t|
      t.string :city
      t.string :region
      t.string :country
      t.string :country_code
      t.string :water_type
      t.string :water_specific
      t.string :timezone
      t.string :languages
      
      t.timestamps
    end

    create_table :destination_conditions do |t|
      t.integer :destination_id
      t.integer :month
      t.float :air_temperature
      t.float :water_temperature
      t.float :rainfall
      t.integer :current_strength
      t.integer :visibility_scale
      
      t.timestamps
    end

    add_column :dive_centers, :destination_id, :integer
    add_foreign_key :dive_centers, :destinations

    add_column :dive_sites, :destination_id, :integer
    add_foreign_key :dive_sites, :destinations
  end
end
