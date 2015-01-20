class AddHateTableToBoss < ActiveRecord::Migration
  def change
    add_column :bosses, :hate_table, :text
  end
end
