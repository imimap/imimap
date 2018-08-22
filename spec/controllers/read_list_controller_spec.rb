# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReadListController, type: :controller do
  render_views

  before :each do
    @current_user = login
    @internship = create :internship
    @read_list = create :read_list, internship: @internship
    @current_user.read_lists << @read_list
  end
end
