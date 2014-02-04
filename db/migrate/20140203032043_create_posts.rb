class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.references :user
      t.text :content
      t.text :image
      t.timestamps
    end
  end
end
