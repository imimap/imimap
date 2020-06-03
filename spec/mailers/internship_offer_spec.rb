# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InternshipOfferMailer, type: :mailer do
  describe 'new_internship_offer' do
    let(:mail) { InternshipOfferMailer.new_internship_offer }

    it 'renders the headers' do
      expect(mail.subject).to eq('New internship offer')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
