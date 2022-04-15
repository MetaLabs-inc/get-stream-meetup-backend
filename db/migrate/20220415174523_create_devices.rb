class CreateDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :devices do |t|
      t.references :user, foreign_key: true
      t.string :auth_token, null: false
      t.timestamps

      t.index :auth_token, unique: true
    end
  end
end
