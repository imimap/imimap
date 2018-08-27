# frozen_string_literal: true

# Companies
FactoryBot.define do
  factory :company_address, class: CompanyAddress do
    street { 'MyString' }
    zip { 'MyString' }
    city { 'MyString' }
    country { 'MyString' }
  end

  factory :company_address_htw, class: CompanyAddress do
    city { 'Berlin' }
    country { 'Germany' }
    street { 'Wilhelminenhofstr. 75 A' }
    zip { '12459' }
  end

  factory :company_is24, class: CompanyAddress do
    city { 'Berlin' }
    country { 'Germany' }
    street { 'Andreasstr. 10' }
    zip { '10243' }
  end
end
