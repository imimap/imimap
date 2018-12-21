# frozen_string_literal: true
# frozen_string_literal: true

# country select now uses ISO Codes by default.
# this task migrates the old data.
# see https://github.com/stefanpenner/country_select/blob/master/UPGRADING.md

namespace :imimap do
  desc 'migrate county data to ISO3166-2'
  task mcc_preview_2: :environment do
    CC = ISO3166::Country
         .codes
         .map { |c| [ISO3166::Country.new(c).name, c] }
         .to_h
         .merge('United States' => 'US',
                'United Kingdom' => 'GB',
                'Czech Republic' => 'CZ')
    puts CC.inspect
    countries = CompanyAddress.pluck(:country).uniq.reject { |c| c.size < 3 }
    countries.each do |c|
      code = CC[c]
      puts "not found: #{c} => #{code}" unless code
    end
  end

  task mcc: :environment do
    cas = CompanyAddress.all
    CC = ISO3166::Country
         .codes
         .map { |c| [ISO3166::Country.new(c).name, c] }
         .to_h
         .merge('United States' => 'US',
                'United Kingdom' => 'GB',
                'Czech Republic' => 'CZ')
    # puts CC.inspect

    puts "Going to update #{cas.count} CompanyAddresses"
    counter = 0
    cas.each do |ca|
      counter += 1
      if ca.country.size < 3
        puts "already ISO: #{ca.country}"
      else
        code = CC[ca.country]
        puts "#{counter}: #{ca.country} => #{code}"
        ca.country = code
        ca.save
      end
    end
  end
end

# "United States of America"=>"US",
