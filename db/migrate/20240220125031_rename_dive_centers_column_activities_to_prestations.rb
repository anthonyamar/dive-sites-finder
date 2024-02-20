class RenameDiveCentersColumnActivitiesToPrestations < ActiveRecord::Migration[7.1]
  def change
    rename_column :dive_centers, :activities, :prestations
  end
end
