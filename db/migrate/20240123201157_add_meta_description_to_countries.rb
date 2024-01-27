class AddMetaDescriptionToCountries < ActiveRecord::Migration[7.1]
  def change
    add_column :countries, :meta_description, :string
  end
end
