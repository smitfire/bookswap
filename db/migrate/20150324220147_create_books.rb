class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author
      t.string :title
      t.text :summary
      t.integer :user_id, index: true
      t.attachment :cover

      t.timestamps
    end

  end
end
