class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, nullable: false, index: { unique: true }
      t.string :password_digest, nullable: false

      t.timestamps
    end
  end
end
