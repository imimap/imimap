# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InternshipsController, type: :controller, topic: :internship do
  include Devise::Test::ControllerHelpers
  include InternshipsHelper
  render_views

  before :each do
    @user = login_as_admin
  end

  describe 'GET #index' do
    it 'renders the index action correctly' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    context 'assignments' do
      before :each do
        @semester = Semester.current
        @internship = create(:internship, completed: true, living_costs: 42,
                                          salary: 84, semester: @semester)

        get :index
      end

      it 'assigns @semester' do
        expect(assigns(:semester)).to eq(@semester)
      end

      it 'assigns @complete_internships' do
        expect(assigns(:complete_internships).first.attribute_array)
          .to eq([InternshipsDtoHelper::InternshipsDto
            .from(@internship)].first.attribute_array)
      end
      it 'assigns @internships' do
        expect(assigns(:internship_count)).to eq(1)
      end
    end
  end
end
