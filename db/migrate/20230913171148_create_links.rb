class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.references  :sharer,  index: true, foreign_key: { to_table: :users }
      t.string      :url,     nullable: false
      t.string      :title,   nullable: false
      t.string      :description

      t.timestamps
    end
  end
end
