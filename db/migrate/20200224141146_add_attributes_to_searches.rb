class AddAttributesToSearches < ActiveRecord::Migration[6.0]
  def change
    add_column :searches, :paid, :boolean
    add_column :searches, :location, :string
    add_column :searches, :orientation_id, :integer
    add_column :searches, :programming_language_id, :integer
  end
end
