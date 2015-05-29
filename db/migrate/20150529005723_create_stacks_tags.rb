class CreateStacksTags < ActiveRecord::Migration
  def change
    create_table :stacks_tags do |t|
      t.integer :stack_id
      t.string :name

      t.timestamps null: false
    end
  end
end
