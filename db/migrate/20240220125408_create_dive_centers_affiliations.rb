class CreateDiveCentersAffiliations < ActiveRecord::Migration[7.1]
  def change
    create_table :dive_centers_affiliations do |t|
      t.references :dive_center, null: false, foreign_key: true
      t.references :affiliation, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
