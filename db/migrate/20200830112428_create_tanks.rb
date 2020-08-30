class CreateTanks < ActiveRecord::Migration[6.0]
  def change
    create_table :tanks do |t|
      t.integer :tank_number, index: { unique: true }
      t.integer :volume
      t.timestamps
    end
  end
end
