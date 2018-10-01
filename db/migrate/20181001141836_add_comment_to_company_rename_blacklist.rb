# frozen_string_literal: true

class AddCommentToCompanyRenameBlacklist < ActiveRecord::Migration[5.2]
  def change
    change_table :companies do |t|
      t.column :comment, :text
      t.rename :blacklisted, :excluded_from_search
    end
  end
end
