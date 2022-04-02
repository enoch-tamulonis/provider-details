class AddNpiNumberToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :npi_number, :integer
  end
end
