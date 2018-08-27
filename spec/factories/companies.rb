# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { 'The IMI-Map Company' }
    number_employees { 2 }
    industry { 'IT' }
    website { 'http://htw-berlin.de' }
      main_language { 'German' }
    phone { '+49123456789' }
    fax { '+49123456789' }
    blacklisted { false }
    import_id { 1 }
  end

  factory :is24, class: Company do
    name { 'Immobilienscout' }
    number_employees { 500 }
    industry { 'IT' }
    website { 'www.immobilienscout24.de' }
    main_language { 'German' }
    phone { '+49123456789' }
    fax { '+49123456789' }
    blacklisted { false }
    import_id { 2 }
  end
end
