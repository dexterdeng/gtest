class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :user, index: true
      t.references :commentable, polymorphic: true, index: true, null: false
      t.integer    :votes_count, default: 0

      t.timestamps
    end
  end
end
