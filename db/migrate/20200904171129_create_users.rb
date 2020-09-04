class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :lastname
      t.string :mail
      t.string :password
      t.string :salt
      t.string :token
      t.timestamps
    end
    add_reference :pressurelogs, :user, index: true
  end
end
