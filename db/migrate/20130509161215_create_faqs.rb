# frozen_string_literal: true

class CreateFaqs < ActiveRecord::Migration[4.2]
  def change
    create_table :faqs, &:timestamps
  end
end
