# frozen_string_literal: true

FactoryBot.define do
  factory :internship do
    before(:create) do |i|
      c = FactoryBot.create(:company)
      i.company = c
      i.company_address = c.company_addresses.first
    end

    working_hours { 2.0 }
    living_costs  { 4.0 }
    internship_rating
    # company
    user
    title { 'The Main Example Intership' }
    recommend { true }
    orientation
    email_public { true }
    description { 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.' }
    semester
    salary { 8 }
    start_date { Date.today.to_date }
    end_date { Date.today.to_date + 7.days }
    tasks { 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.' }
    operational_area { 'operational area' }
    student
    internship_state
    reading_prof
    payment_state
    registration_state
    contract_state
    report_state
    certificate_state
    certificate_signed_by_internship_officer { Date.today.to_date }
    certificate_signed_by_prof { Date.today.to_date }
    certificate_to_prof { Date.today.to_date }
    comment { 'internship comment' }
    supervisor_email { 'supervisor@bar.com' }
    supervisor_name { 'internship supervisor name' }
    completed { false }
    internship_report { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'test.pdf')) }
    after(:build) do |i|
      c = FactoryBot.build(:company)
      i.company = c
      i.company_address = c.company_addresses.first
    end
    after(:create) do |i|
      c = FactoryBot.create(:company)
      i.company = c
      i.company_address = c.company_addresses.first
    end
  end
end
