### All Tests fail locally / On SQLite
NotNullConstraint on ids: run rake db:migrate helped, removed the id: :serial
in the table declarations in db/schema.rb

-  create_table "admin_users", id: :serial, force: :cascade do |t|
+  create_table "admin_users", force: :cascade do |t|
