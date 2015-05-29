class CreateStacks < ActiveRecord::Migration
  def change
    create_table :stacks do |t|
      t.string :title
      t.string :problem
      t.string :solution
      t.string :explanation
      t.string :url1
      t.string :url2
      t.string :url3
      t.binary :picture1, limit: 16000000
      t.binary :picture2, limit: 16000000
      t.binary :picture3, limit: 16000000
      t.integer :user_id
      t.integer :previous_id

      t.timestamps null: false
    end
  end
end
