class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name
      t.text :introduction
      t.string :image_id
      t.integer :price_without_tax
      t.boolean :is_sold, default: true

      t.timestamps
    end
  end
end
