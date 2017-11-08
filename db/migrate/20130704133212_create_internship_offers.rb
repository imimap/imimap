class CreateInternshipOffers < ActiveRecord::Migration[4.2]
  def change
    create_table :internship_offers do |t|
    	t.string :title
    	t.text :body
    	t.string :pdf

      t.timestamps
    end
  end
end
