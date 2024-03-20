class AddDefaultToCapitalCity < ActiveRecord::Migration[7.1]
  def change
    change_column_default :cities, :capital_city, from: nil, to: false
  end
end
