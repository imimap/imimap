class CreateQuicksearches < ActiveRecord::Migration[4.2]
  def change
    create_table :quicksearches do |t|

      t.timestamps
    end
  end
end
