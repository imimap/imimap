class SetRecommendToTrueDefault < ActiveRecord::Migration[4.2]
  def change  	
      change_column :internships, :recommend, :boolean, :default => true
  end
end
