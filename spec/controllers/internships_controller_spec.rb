# frozen_string_literal: true

require 'rails_helper'

include CompleteInternshipHelper
RSpec.describe InternshipsController, type: :controller do
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
        @semester = create(:ws2018)
        @internship = create(:internship, completed: true, living_costs: 42,
                                          salary: 84, semester: @semester)

        get :index
      end

      it 'assigns @semester_name' do
        expect(assigns(:semester_name)).to eq(@semester.name)
      end

      it 'assigns @complete_internships' do
        expect(assigns(:complete_internships)).to eq([CompleteInternship.from(@internship)])
      end
      it 'assigns @internships' do
        expect(assigns(:internship_count)).to eq(1)
      end
    end
  end

  describe 'controller' do
    it 'update' do
      @internship = create(:internship)
      @programming_language = create(:programming_language)
      visit edit_admin_internship_path(id: @internship)
      fill_in Internships.human_attribute_name(:programming_language),
              with: @programming_language
      click_on t('helpers.submit.update', model: Internships.model_name.human)
      expect(page).to have_content @programming_language
    end
  end
end
# describe 'GET #show' do
#  before :each do
#    @internship = create :internship, completed: true
#  end

#  it 'renders the show action correctly' do
#    get :show, params: { id: @internship }
#    expect(response).to have_http_status(:success)
#    expect(response).to render_template(:show)
#  end

#  context 'assignments' do

#    it 'assigns @internship' do
#      get :show, params: { id: @internship }
#      expect(assigns(:internship)).to eq(@internship)
#    end

#    it 'assigns @favorite' do
#      favorite = create :favorite, internship_id: @internship.id, user_id: @current_user.id
#      get :show, params: { id: @internship }
#      expect(assigns(:favorite)).to eq(favorite)
#    end

#    it 'assigns @other_internships correctly' do
#      get :show, params: { id: @internship }
#      expect(assigns(:other_internships)).to eq([])
#    end

#    it 'assigns @user_comments correctly' do

#      #user_comment = create :user_comment, internship: @internship
#      #@internship.user_comments << user_comment
#      get :show, params: { id: @internship }
#      expect(assigns(:user_comments)).to eq([])
#    end
#  end
# end

# describe 'GET #edit' do
#  before :each do
#    @internship = create :internship, student: @current_user.student
#  end

#  it 'renders the edit action correctly' do
#    get :edit, params: { id: @internship }
#    expect(response).to have_http_status(:success)
#    expect(response).to render_template(:edit)
#  end

#  context 'assignments' do
#    it 'assigns @internship' do
#      get :edit, params: { id: @internship }
#      expect(assigns(:internship)).to eq(@internship)
#    end

#    it 'assigns @company' do
#      get :edit, params: { id: @internship }
#      expect(assigns(:company)).to eq(@internship.company)
#    end

#    it 'assigns @rating' do
#      get :edit, params: { id: @internship }
#      expect(assigns(:rating)).to eq(@internship.internship_rating)
#    end
#  end

# end

# describe 'PUT #update' do
#  before :each do
#    @internship = create :internship, student: @current_user.student, title: 'Foo'
#  end

#  context 'given correct parameters' do
#    it 'updates the specified Internship' do
#      put :update, params: { id: @internship, internship: attributes_for(:internship, title: 'Bar') }
#      @internship.reload
#      expect(@internship.title).to eq('Bar')
#    end
#  end

#  context 'given incorrect parameters' do
#    it 'refuses to update the specified Internship' do
#      semester_id = @internship.semester_id
#      put :update, params: { id: @internship, internship: attributes_for(:internship, semester_id: nil) }
#      @internship.reload
#      expect(@internship.semester_id).to eq(semester_id)
#    end
#  end
# end

# describe 'DELETE #destroy' do
#  it 'destroys the specified internship' do
#    @internship = create :internship, student: @current_user.student
#    expect {
#      delete :destroy, params: { id: @internship }
#      }.to change(Internship, :count).by(-1)
#    end
#  end

#  describe '#internship_data' do

#    context 'the user has an internship' do
#      it 'renders the my_internship view' do
#        @internship = create :internship
#        get :show, params: { id: @internship }
#        expect(response).to render_template(:show)
#      end
#    end

#    context 'the internship can not be found' do
#      it 'renders the no_internship_data view' do
#        get :internship_data, params: { id: 42 }
#        expect(response).to render_template(:no_internship_data)
#      end
#    end
#  end

#  describe 'private #authorize_internship' do

#    context 'the user is not associated to the internship' do
#      it 'redirects to overview_index' do
#        @internship = create :internship
#        get :edit, params: { id: @internship }
#        expect(response).to redirect_to(:overview_index)
#      end
#    end

#    context 'the internship can not be found' do
#      it 'redirects to overview_index' do
#        get :edit, params: { id: 42 }
#        expect(response).to redirect_to(:overview_index)
#      end
#    end
#  end
