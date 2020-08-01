# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers'

describe 'ActiveAdmin InternshipOffer Edit' do
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    I18n.locale = 'de'
  end
  it 'edits internship_offer' do
    #  fields = %w[street zip city phone fax latitude longitude]

    internship_offer = create(:internship_offer)
    visit edit_admin_internship_offer_path(id: internship_offer)
    uncheck 'internship_offer_active'
    click_on I18n.t('helpers.submit.update',
                    model: InternshipOffer.model_name.human)

    internship_offer.reload
    expect(internship_offer.active).to be false
  end
end
