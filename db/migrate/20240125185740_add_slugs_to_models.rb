class AddSlugsToModels < ActiveRecord::Migration[7.1]
  def change
    add_column :geo_groups, :slug, :string
    add_index :geo_groups, :slug, unique: true
    
    add_column :countries, :slug, :string
    add_index :countries, :slug, unique: true
    
    add_column :regions, :slug, :string
    add_index :regions, :slug, unique: true
    
    add_column :cities, :slug, :string
    add_index :cities, :slug, unique: true
    
    add_column :dive_centers, :slug, :string
    add_index :dive_centers, :slug, unique: true
    
    add_column :dive_sites, :slug, :string
    add_index :dive_sites, :slug, unique: true
  end
end
