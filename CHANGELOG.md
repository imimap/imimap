


* Updated Rails to 6.0.0. See https://guides.rubyonrails.org/upgrading_ruby_on_rails.html#upgrading-from-rails-5-2-to-rails-6-0
* Updated ActiveAdmin to 2.2


-  create_table "admin_users", id: :serial, force: :cascade do |t|
+  create_table "admin_users", force: :cascade do |t|
