class CreateFaqs < ActiveRecord::Migration[4.2]
  def change
    create_table :faqs do |t|

      t.timestamps
    end
  end
end
