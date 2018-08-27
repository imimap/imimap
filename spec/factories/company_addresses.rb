# frozen_string_literal: true

# Companies
FactoryBot.define do
  factory :company_address_htw, class: CompanyAddress do
    city { 'Berlin' }
    country { 'Germany' }
    street { 'Wilhelminenhofstr. 75 A' }
    zip { '12459' }
    phone { '+49123456789' }
    fax { '+49123456789' }
    company
  end

  factory :company_address_is24, class: CompanyAddress do
    city { 'Berlin' }
    country { 'Germany' }
    street { 'Andreasstr. 10' }
    zip { '10243' }
    phone { '+49123456789' }
    fax { '+49123456789' }
    company
  end
end
