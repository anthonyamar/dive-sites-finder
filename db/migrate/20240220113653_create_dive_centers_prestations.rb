class CreateDiveCentersPrestations < ActiveRecord::Migration[7.1]
  def change
    create_table :dive_centers_prestations do |t|
      t.references :dive_center, null: false, foreign_key: true
      t.references :prestation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
