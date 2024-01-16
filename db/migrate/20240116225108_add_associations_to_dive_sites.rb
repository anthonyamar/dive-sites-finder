class AddAssociationsToDiveSites < ActiveRecord::Migration[7.1]
  def change
    add_reference :dive_sites, :geo_group, foreign_key: true
    add_reference :dive_sites, :country, foreign_key: true
    add_reference :dive_sites, :region, foreign_key: true
    add_reference :dive_sites, :city, foreign_key: true
  end
end
