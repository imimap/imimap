# frozen_string_literal: true

if !ENV['GOOGLE_API_KEY'].nil?
  puts 'Geocoder: using google'
  Geocoder.configure(
    timeout: 10,
    lookup: :google,
    api_key: (ENV['GOOGLE_API_KEY']).to_s,
    language: :en,
    units: :km
  )
else
  puts 'Geocoder: using nominatim'
  Geocoder.configure(
    timeout: 10,
    lookup: :nominatim,
    language: :en,
    units: :km
  )
end
