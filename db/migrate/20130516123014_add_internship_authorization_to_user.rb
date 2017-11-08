class AddInternshipAuthorizationToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :internship_authorization, :boolean, :default => true
  end
end
