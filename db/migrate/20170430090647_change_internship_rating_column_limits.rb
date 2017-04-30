class ChangeInternshipRatingColumnLimits < ActiveRecord::Migration
  def up
    change_column :internship_ratings, :tasks, :integer, :limit => 2
    change_column :internship_ratings, :training_success, :integer, :limit => 2
    change_column :internship_ratings, :atmosphere, :integer, :limit => 2
    change_column :internship_ratings, :supervision, :integer, :limit => 2
    change_column :internship_ratings, :appreciation,:integer,  :limit => 2
  end

  def down
    change_column :internship_ratings, :tasks, :integer, :limit => 1
    change_column :internship_ratings, :training_success,:integer, :limit => 1
    change_column :internship_ratings, :atmosphere, :integer, :limit => 1
    change_column :internship_ratings, :supervision, :integer, :limit => 1
    change_column :internship_ratings, :appreciation, :integer, :limit => 1
  end
end
