# frozen_string_literal: true

TEXT4 = <<DELIM
  Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
  incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
  nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore
  eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
  sunt in culpa qui officia deserunt mollit anim id est laborum
DELIM

FactoryBot.define do
  factory :internship do
    before(:create) do |i|
      c = FactoryBot.create(:company)
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
    description { TEXT4 }
    complete_internship
    salary { 8 }
    start_date { Date.today.to_date }
    end_date { Date.today.to_date + 7.days }
    tasks { 'do this and that and the other thing' }
    operational_area { 'operational area' }
    semester
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
    internship_report do
      Rack::Test::UploadedFile.new(File.join(Rails.root,
                                             'spec', 'support', 'test.pdf'))
    end
    after(:build) do |i|
      c = FactoryBot.build(:company)
      i.company_address = c.company_addresses.first
    end
    after(:create) do |i|
      c = FactoryBot.create(:company)
      i.company_address = c.company_addresses.first
    end
  end

  factory :internship_1, class: Internship do
    before(:create) do |i|
      c = FactoryBot.create(:company_1)
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
    description { TEXT4 }
    semester
    salary { 8 }
    start_date { Date.today.to_date }
    end_date { Date.today.to_date + 7.days }
    tasks { TEXT4 }
    operational_area { 'operational area' }
    internship_state { create :internship_state_aep }
    complete_internship
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
    internship_report do
      Rack::Test::UploadedFile.new(
        File.join(
          Rails.root, 'spec', 'support', 'test.pdf'
        )
      )
    end
    after(:build) do |i|
      c = FactoryBot.build(:company_1)
      i.company_address = c.company_addresses.first
    end
    after(:create) do |i|
      c = FactoryBot.create(:company_1)
      i.company_address = c.company_addresses.first
    end
  end

  factory :internship_2, class: Internship do
    before(:create) do |i|
      c = FactoryBot.create(:company_2)
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
    description { TEXT4 }
    semester
    salary { 8 }
    start_date { Date.today.to_date }
    end_date { Date.today.to_date + 7.days }
    tasks { TEXT4 }
    operational_area { 'operational area' }
    complete_internship
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
    internship_report do
      Rack::Test::UploadedFile.new(
        File.join(
          Rails.root, 'spec', 'support', 'test.pdf'
        )
      )
    end

    after(:build) do |i|
      c = FactoryBot.build(:company_2)
      i.company_address = c.company_addresses.first
    end
    after(:create) do |i|
      c = FactoryBot.create(:company_2)
      i.company_address = c.company_addresses.first
    end
  end

  factory :unassociated_internship, class: Internship do
    before(:create) do |i|
      c = FactoryBot.create(:company_1)
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
    description { TEXT4 }
    semester
    salary { 8 }
    start_date { Date.today.to_date }
    end_date { Date.today.to_date + 7.days }
    tasks { TEXT4 }
    operational_area { 'operational area' }
    internship_state { create :internship_state_aep }
    complete_internship { create :complete_internship_wo_student }
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
    internship_report do
      Rack::Test::UploadedFile.new(
        File.join(
          Rails.root, 'spec', 'support', 'test.pdf'
        )
      )
    end
    after(:build) do |i|
      c = FactoryBot.build(:company_1)
      i.company_address = c.company_addresses.first
    end
    after(:create) do |i|
      c = FactoryBot.create(:company_1)
      i.company_address = c.company_addresses.first
    end
  end

  factory :internship_without_states, class: Internship do
    before(:create) do |i|
      c = FactoryBot.create(:company_2)
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
    description { TEXT4 }
    semester
    salary { 8 }
    start_date { Date.today.to_date }
    end_date { Date.today.to_date + 7.days }
    tasks { TEXT4 }
    operational_area { 'operational area' }
    complete_internship
    reading_prof
    payment_state
    certificate_signed_by_internship_officer { Date.today.to_date }
    certificate_signed_by_prof { Date.today.to_date }
    certificate_to_prof { Date.today.to_date }
    comment { 'internship comment' }
    supervisor_email { 'supervisor@bar.com' }
    supervisor_name { 'internship supervisor name' }
    completed { false }
    internship_report do
      Rack::Test::UploadedFile.new(
        File.join(
          Rails.root, 'spec', 'support', 'test.pdf'
        )
      )
    end

    after(:build) do |i|
      c = FactoryBot.build(:company_2)
      i.company_address = c.company_addresses.first
    end
    after(:create) do |i|
      c = FactoryBot.create(:company_2)
      i.company_address = c.company_addresses.first
    end
  end
end
