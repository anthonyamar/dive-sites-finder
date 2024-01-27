class CreateGeoGroupsCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :geo_groups_countries do |t|
      t.references :geo_group, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
