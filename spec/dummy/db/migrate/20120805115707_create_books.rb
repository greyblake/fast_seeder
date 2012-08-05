class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author
      t.string :name
      t.integer :published_in

      t.timestamps
    end
  end
end
