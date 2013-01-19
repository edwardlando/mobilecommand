class CreatePastposts < ActiveRecord::Migration
  def change
    create_table :pastposts do |t|
      t.string :shortlink
      t.string :body

      t.timestamps
    end
  end
end
