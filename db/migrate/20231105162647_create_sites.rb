class CreateSites < ActiveRecord::Migration[7.1]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :bow
      t.float :longitude
      t.float :latitude
      t.string :address
      t.string :region
      t.string :country
      t.boolean :is_private

      t.timestamps
    end
  end
end
