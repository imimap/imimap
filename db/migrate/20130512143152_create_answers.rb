class CreateAnswers < ActiveRecord::Migration[4.2]
  def change
    create_table :answers do |t|
      t.text :body

      t.timestamps
    end
  end
end
