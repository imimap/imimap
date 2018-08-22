# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InternshipNotificationHandler, type: :model do
  let(:internship_notification_handler) do
    InternshipNotificationHandler.new internship: create(:internship)
  end

  it 'should create a new InternshipNotificationHandler object' do
    expect(internship_notification_handler.internship).to be_truthy
  end

  describe '#notify' do
    it 'should execute' do
      expect(internship_notification_handler.notify).to be_truthy
    end
  end
end
