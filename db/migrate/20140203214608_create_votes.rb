class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :upvote
      t.boolean :downvote
      t.references :post
      t.references :user
      t.timestamps
    end
  end
end
