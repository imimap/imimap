# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ApplicationRecord has methods for required attributes',
               type: :model do
  context 'Company and CompanyAddress' do
    it 'required attributes for save (Company)' do
      expect(Company.attributes_required_for_save).to(
        match_array([:name])
      )
    end
    it 'required attributes for save (CompanyAddress)' do
      expect(CompanyAddress.attributes_required_for_save).to(
        match_array(%i[street country zip city company])
      )
    end
    it 'required attributes for application (CompanyAddress)' do
      expect(CompanyAddress.attributes_required_for_internship_application).to(
        match_array([])
      )
    end
  end
  context 'Internship' do
    it 'required attributes for application (Internship)' do
      expect(Internship.attributes_required_for_internship_application).to(
        match_array(%i[semester start_date end_date working_hours tasks
                       operational_area supervisor_name supervisor_email
                       supervisor_phone])
      )
    end
  end
end
