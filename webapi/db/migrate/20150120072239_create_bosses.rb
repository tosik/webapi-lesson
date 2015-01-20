class CreateBosses < ActiveRecord::Migration
  def change
    create_table :bosses do |t|
      t.integer :hp
      t.integer :number_of_actions

      t.timestamps null: false
    end
  end
end
