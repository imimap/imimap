class CreateUserCanSeeCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :user_can_see_companies do |t|
      t.references :company, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :created_by, default: 0

      t.timestamps
    end
  end
end
