class AddKindToGeoGroup < ActiveRecord::Migration[7.1]
  def change
    add_column :geo_groups, :kind, :string
  end
end
