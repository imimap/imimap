# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  before :each do
    @answer = create :answer
  end

  context 'given a valid Answer' do
    it 'can be saved with all required attributes present' do
      # FactoryBot 5 factories now inherit their parent's create strategy
      # https://www.rubydoc.info/gems/factory_bot/file/GETTING_STARTED.md
      # had to simplify this test:
      expect(@answer.errors).to be_empty
    end
  end

  context 'given an invalid Answer' do
    it 'rejects an empty body' do
      @answer.body = nil
      expect(@answer.save).to be_falsy
    end

    it 'rejects an empty internship_id' do
      @answer.internship_id = nil
      expect(@answer.save).to be_falsy
    end

    it 'rejects an empty user_comment_id' do
      @answer.user_comment_id = nil
      expect(@answer.save).to be_falsy
    end
  end
end
