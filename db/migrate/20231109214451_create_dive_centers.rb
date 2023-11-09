class CreateDiveCenters < ActiveRecord::Migration[7.1]
  def change
    create_table :dive_centers do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :web_url
      t.float :longitude
      t.float :latitude
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :country_code
      t.text :activities, array: true, default: []
      
      t.timestamps
    end
  end
end
