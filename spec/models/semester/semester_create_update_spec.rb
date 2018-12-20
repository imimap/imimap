# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Semester, type: :model do
  def test_data
    [['SS 13', 2013.1],
     ['WS 12/13', 2012.2],
     ['WS 15/16', 2015.2],
     ['SS 11', 2011.1]]
  end

  describe 'create' do
    it 'sets sid if only name is given' do
      test_data.each do |name, sid|
        s = Semester.create(name: name)
        expect(s.sid).to eq(sid)
      end
    end

    it 'sets name if only sid is given' do
      test_data.each do |name, sid|
        s = Semester.create(sid: sid)
        expect(s.name).to eq(name)
      end
    end
  end
  
end
