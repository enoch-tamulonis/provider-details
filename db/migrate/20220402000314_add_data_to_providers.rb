class AddDataToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :data, :text
  end
end
