class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|

      t.string :image_url
      t.string :image_key
      t.timestamps
    end
  end
end
