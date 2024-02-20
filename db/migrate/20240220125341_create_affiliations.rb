class CreateAffiliations < ActiveRecord::Migration[7.1]
  def change
    create_table :affiliations do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.integer :dive_centers_count, default: 0
      
      t.timestamps
    end
  end
end
