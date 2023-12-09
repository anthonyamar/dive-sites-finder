class RenameSiteToDiveSite < ActiveRecord::Migration[7.1]
  def change
    rename_table :sites, :dive_sites
  end
end
