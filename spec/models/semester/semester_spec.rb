# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Semester, type: :model do
  let(:student) { build :semester }

  describe '' do
    it 'returns semester for date' do
      today = Date.iso8601('2018-12-10')
      semester = Semester.for_date(today)
      expect(semester.name).to eq 'WS 18/19'
      expect(semester.sid).to eq 2018.2
      expect(semester.year).to eq 2018
    end
    it 'orders semesters' do
      today = Date.iso8601('2018-12-10')
      semester = Semester.for_date(today)
      next_semester = semester.next
      expect(next_semester.name).to eq 'SS 19'
    end
    it 'creates automatically' do
      expect do
        Semester.for_date(Date.iso8601('2018-12-10'))
      end.to change { Semester.count }.by(1)
    end
    it 'knows current semester' do
      expect(Semester.current).to eq Semester.for_date(Date.today)
    end
    it 'knows next semester' do
      expect(Semester.next).to eq Semester.for_date(Date.today).next
    end
    it 'orders semesters chronologically' do
      ['SS 13', 'WS 12/13', 'SS 12', 'WS 11/12', 'WS 14/15', 'SS 15',
       'WS 15/16', 'SS 16', 'WS 16/17', 'SS 17', 'WS 17/18', 'SS 18',
       'WS 18/19', 'SS 11', 'WS 10/11', 'SS 10', 'WS 09/10', 'SS 09',
       'WS 13/14', 'SS 14', 'WS 08/09', 'WS 07/08', 'SS 06', 'SS 08',
       'WS 06/07', 'SS 04', 'SS 07', 'SS 19'].shuffle.each do |name|
        Semester.create(name: name)
      end
      all = Semester.all
      expect(all.first.name).to eq 'SS 04'
      expect(all[6].name).to eq 'WS 15/16'

      # default_scope :order => 'tasks.position' # assuming the column name is position
    end
    it 'converts' do
      expect(Semester.name2sid('WS 16/17')).to eq 2016.2
      expect(Semester.name2sid('SS 19')).to eq 2019.1
    end
  end
end

# irb(main):002:0> Semester.all.pluck(:name)
#   (8.9ms)  SELECT "semesters"."name" FROM "semesters"
#=> ["SS 13", "WS 12/13", "SS 12", "WS 11/12", "WS 14/15", "SS 15", "WS 15/16", "SS 16", "WS 16/17", "SS 17", "WS 17/18", "SS 18", "WS 18/19", "SS 11", "WS 10/11", "SS 10", "WS 09/10", "SS 09", "WS 13/14", "SS 14", "WS 08/09", "WS 07/08", "SS 06", "SS 08", "WS 06/07", "SS 04", "SS 07", "SS 19"]
