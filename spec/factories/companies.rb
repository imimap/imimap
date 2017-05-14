FactoryGirl.define do
  factory :company do
    name "The IMI-Map Company"
    number_employees 2
    industry "IT"
    website "http://htw-berlin.de"
    city "Berlin"
    country "Germany"
    street "Wilhelminenhofstr. 75 A"
    zip "12459"
    main_language "German"
    phone "+49123456789"
    fax "+49123456789"
    blacklisted false
    import_id 1
  end
end
