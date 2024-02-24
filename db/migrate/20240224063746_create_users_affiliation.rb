class CreateUsersAffiliation < ActiveRecord::Migration[7.1]
  def change
    create_table :users_affiliations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :affiliation, null: false, foreign_key: true

      t.timestamps
    end
    
    add_column :affiliations, :users_count, :integer, default: 0
  end
end
