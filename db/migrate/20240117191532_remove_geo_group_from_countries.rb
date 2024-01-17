class RemoveGeoGroupFromCountries < ActiveRecord::Migration[7.1]
  def change
    remove_reference :countries, :geo_group, index: true, foreign_key: true
  end
end