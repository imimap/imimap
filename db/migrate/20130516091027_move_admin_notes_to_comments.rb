class MoveAdminNotesToComments < ActiveRecord::Migration
  def self.up
    remove_index  :admin_notes, [:admin_user_type, :admin_user_id]
    rename_table  :admin_notes, :active_admin_comments
    rename_column :active_admin_comments, :admin_user_type, :author_type
    rename_column :active_admin_comments, :admin_user_id, :author_id
    add_column    :active_admin_comments, :namespace, :string
    add_index     :active_admin_comments, [:namespace]
    add_index     :active_admin_comments, [:author_type, :author_id]


    # Update all the existing comments to the default namespace
    name_space = ActiveAdmin.application.default_namespace 
    say "Updating any existing comments to the #{name_space} namespace."

    #comments_table_name = ActiveRecord::Migrator.proper_table_name("active_admin_comments")
    # removed in rails 4.2
    comments_table_name = "active_admin_comments"
    execute "UPDATE #{comments_table_name} SET namespace='#{name_space}'"
  end

  def self.down
    remove_index  :active_admin_comments, :column => [:author_type, :author_id]
    remove_index  :active_admin_comments, :column => [:namespace]
    remove_column :active_admin_comments, :namespace
    rename_column :active_admin_comments, :author_id, :admin_user_id
    rename_column :active_admin_comments, :author_type, :admin_user_type
    rename_table  :active_admin_comments, :admin_notes
    add_index     :admin_notes, [:admin_user_type, :admin_user_id]
  end
end
