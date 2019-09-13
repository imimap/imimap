class AddFeatureTogglesToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :feature_toggles, :text
  end
end
