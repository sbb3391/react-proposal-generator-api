class AddImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|

      t.string :image_items
      t.timestamps
    end
  end
end
