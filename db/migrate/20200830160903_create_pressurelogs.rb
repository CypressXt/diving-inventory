class CreatePressurelogs < ActiveRecord::Migration[6.0]
  def change
    create_table :pressurelogs do |t|
      t.belongs_to :tank, index: true
      t.integer :pressure_start
      t.integer :pressure_end
      t.integer :o2_percentage
      t.datetime :filling_timestamp
      t.datetime :emptying_timestamp
      t.timestamps
    end
  end
end
