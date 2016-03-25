class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string   :url, :image_file_name, :image_content_type, limit: 255
      t.integer  :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
