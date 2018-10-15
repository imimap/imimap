require 'rails_helper'
RSpec.describe CompleteInternshipHelper, type: :helper do

  before :each do
    @internship = create :internship
  end

  describe '#add_student_info' do
    it 'should store information of student in variables' do

      expect(helper.add_student_info(@internship)).to eql('(no student)')
    end

  end

describe '#add_company_info' do

end

describe '#add_status_info' do

end

describe '#CompleteInternship.from' do

end

end
