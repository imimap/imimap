class CreateDownloads < ActiveRecord::Migration[4.2]
  def change
    create_table :downloads do |t|

      t.timestamps
    end
  end
end
