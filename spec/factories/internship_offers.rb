# frozen_string_literal: true

text3 = <<DELIM
  Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
  incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
  nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore
  eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
  sunt in culpa qui officia deserunt mollit anim id est laborum
DELIM

text4 = <<DELIM
  Tolle Stelle.
DELIM

FactoryBot.define do
  factory :internship_offer do
    title { 'Cool Internship Position 1' }
    body { text3 }
    pdf { 'internship offer pdf' }
    city { 'London' }
    country { 'UK' }
    active { true }
  end
  factory :io2, class: InternshipOffer do
    title { 'Cool Internship Position 2' }
    body { text3 }
    pdf { 'internship offer pdf' }
    city { 'San Francisco' }
    country { 'US' }
    active { true }
  end
  factory :io3, class: InternshipOffer do
    title { 'Cool Internship Position 3' }
    body { text3 }
    pdf { 'internship offer pdf' }
    city { 'Paris' }
    country { 'FR' }
    active { true }
  end
  factory :iox, class: InternshipOffer do
    title { 'Not so cool Internship Position' }
    body { text4 }
    pdf { 'internship offer pdf' }
    city { 'Bielefeld' }
    country { 'DE' }
    active { false }
  end
end
