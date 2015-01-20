class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.text :text
      t.references :boss, index: true

      t.timestamps null: false
    end
    add_foreign_key :activities, :bosses
  end
end
