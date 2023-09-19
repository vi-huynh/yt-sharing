class AddVideoIdToLink < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :video_id, :string
    add_index :links, :video_id, unique: true
  end
end
