class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true, index: true, null: false
      t.references :user, null: false, index: true
      t.timestamps
    end
  end
end
