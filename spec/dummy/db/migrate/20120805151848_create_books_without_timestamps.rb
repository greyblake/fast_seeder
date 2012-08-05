class CreateBooksWithoutTimestamps < ActiveRecord::Migration
  def change
    create_table :books_without_timestamps do |t|
      t.string :author
      t.string :name
      t.integer :published_in
    end
  end
end
