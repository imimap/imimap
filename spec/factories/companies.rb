# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { 'The IMI-Map Company' }
    number_employees { 2 }
    industry { 'IT' }
    website { 'http://htw-berlin.de' }
    main_language { 'German' }
    excluded_from_search { false }
    import_id { 1 }
    after(:build) do |company, _evaluator|
      create(:company_address_htw, company: company)
    end
    # after(:create) do |company, _evaluator|
    #  create(:company_address_htw, company: company)
    # end
    comment { 'this says something about the company' }
  end

  factory :company_is24, class: Company do
    name { 'Immobilienscout' }
    number_employees { 500 }
    industry { 'IT' }
    website { 'www.immobilienscout24.de' }
    main_language { 'German' }
    excluded_from_search { false }
    import_id { 2 }
    after(:build) do |company, _evaluator|
      create(:company_address_is24, company: company)
    end
    # after(:create) do |company, _evaluator|
    #  create(:company_address_is24, company: company)
    # end
    comment { 'this says something about the company' }
  end
  factory :company03, class: Company do
    name { 'Just a name' }
    number_employees { 500 }
    industry { 'IT' }
    website { 'www.justname.de' }
    main_language { 'German' }
    excluded_from_search { false }
    import_id { 2 }
    after(:build) do |company, _evaluator|
      create(:company_address02, company: company)
    end
    # after(:create) do |company, _evaluator|
    #  create(:company_address_is24, company: company)
    # end
    comment { 'this says something about the company' }
  end
  factory :company04, class: Company do
    name { 'Another One' }
    number_employees { 500 }
    industry { 'IT' }
    website { 'www.another.de' }
    main_language { 'German' }
    excluded_from_search { false }
    import_id { 2 }
    after(:build) do |company, _evaluator|
      create(:company_address01, company: company)
    end
    # after(:create) do |company, _evaluator|
    #  create(:company_address_is24, company: company)
    # end
    comment { 'this says something about the company' }
  end
  factory :company05, class: Company do
    name { 'Fifth Avenue' }
    number_employees { 500 }
    industry { 'IT' }
    website { 'www.thefifth.de' }
    main_language { 'German' }
    excluded_from_search { false }
    import_id { 2 }
    after(:build) do |company, _evaluator|
      create(:company_address01, company: company)
    end
    # after(:create) do |company, _evaluator|
    #  create(:company_address_is24, company: company)
    # end
    comment { 'this says something about the company' }
  end
  factory :company01, class: Company do
    name { 'Company 1' }
    number_employees { 500 }
    industry { 'IT' }
    website { 'www.company1.de' }
    main_language { 'English' }
    excluded_from_search { false }
    import_id { 2 }
    after(:build) do |company, _evaluator|
      create(:company_address01, company: company)
    end
    #  after(:create) do |company, _evaluator|
    #    create(:company_address01, company: company)
    #  end
    comment { 'this says something about the company' }
  end

  factory :company02, class: Company do
    name { 'Company 2' }
    number_employees { 500 }
    industry { 'IT' }
    website { 'www.company2.de' }
    main_language { 'English' }
    excluded_from_search { false }
    import_id { 2 }
    after(:build) do |company, _evaluator|
      create(:company_address02, company: company)
    end
    #  after(:create) do |company, _evaluator|
    #    create(:company_address02, company: company)
    #  end
    comment { 'this says something about the company' }
  end

  factory :company_without_address, class: Company do
    name { 'Brillenmode am Lausitzer Platz' }
    number_employees { 10 }
    industry { 'Optiker' }
    website { 'https://www.brillenmode-berlin.de' }
    main_language { 'German' }
    excluded_from_search { false }
    import_id { 6 }
    comment { 'ein kleiner optiker' }
  end

  factory :company_m, class: Company do
    name { 'M' }
    number_employees { 2 }
    industry { 'IT' }
    website { 'http://htw-berlin.de' }
    main_language { 'German' }
    excluded_from_search { false }
    import_id { 1 }
    after(:build) do |company, _evaluator|
      create(:company_address_htw, company: company)
    end
    # after(:create) do |company, _evaluator|
    #  create(:company_address_htw, company: company)
    # end
    comment { 'this says something about the company' }
  end
end
