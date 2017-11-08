class AddLinkToNotifications < ActiveRecord::Migration[4.2]
  def change
    add_column :notifications, :link, :string
  end
end
