class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :reviewer_id
      t.integer :post_id
      t.integer :vote, default: 0

      t.timestamps
    end

    add_index :reviews, :reviewer_id
    add_index :reviews, :post_id
    add_index :reviews, [:reviewer_id, :post_id], unique: true
  end
end
