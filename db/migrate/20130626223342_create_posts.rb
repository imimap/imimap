class CreatePosts < ActiveRecord::Migration[4.2]
  def change
    create_table :posts do |t|
      t.text :body
      t.string :email

      t.timestamps
    end
  end
end
