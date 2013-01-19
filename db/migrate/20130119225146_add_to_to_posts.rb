class AddToToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :to, :string
  end
end
