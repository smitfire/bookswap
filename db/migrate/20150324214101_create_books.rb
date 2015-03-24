class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.integer :price
      t.text :summary
      t.string :author
      t.refernces :user

      t.timestamps
    end
  end
end
