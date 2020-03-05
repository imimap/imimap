class CreateUserCanSeeInternships < ActiveRecord::Migration[6.0]
  def change
    create_table :user_can_see_internships do |t|
      t.references :internship, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
