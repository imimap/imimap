# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { 'The IMI-Map Company' }
    number_employees { 2 }
    industry { 'IT' }
    website { 'http://htw-berlin.de' }
    main_language { 'German' }
    blacklisted { false }
    import_id { 1 }
    after(:build) do |company, _evaluator|
      create(:company_address_htw, company: company)
    end
    after(:create) do |company, _evaluator|
      create(:company_address_htw, company: company)
    end
  end

  factory :company_is24, class: Company do
    name { 'Immobilienscout' }
    number_employees { 500 }
    industry { 'IT' }
    website { 'www.immobilienscout24.de' }
    main_language { 'German' }
    blacklisted { false }
    import_id { 2 }
    after(:build) do |company, _evaluator|
      create(:company_address_is24, company: company)
    end
    after(:create) do |company, _evaluator|
      create(:company_address_is24, company: company)
    end
  end

end
