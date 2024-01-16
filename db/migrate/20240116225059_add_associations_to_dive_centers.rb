class AddAssociationsToDiveCenters < ActiveRecord::Migration[7.1]
  def change
    add_reference :dive_centers, :geo_group, foreign_key: true
    add_reference :dive_centers, :country, foreign_key: true
    add_reference :dive_centers, :region, foreign_key: true
    add_reference :dive_centers, :city, foreign_key: true
  end
end
