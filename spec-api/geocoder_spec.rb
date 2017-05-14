require 'rails_helper'

describe "how we expect to use the geocoder gem" do
  # http://www.rubygeocoder.com
  # https://github.com/alexreisner/geocoder
  before :each do
    @company = build :company

    @is24 = build :is24
    Geocoder.configure({:lookup => :google, :timeout => 100})
    Geocoder.configure(lookup: :google)
    Geocoder.configure(timeout: 100)
  end

  context 'given a valid Company' do
    it 'geocodes the HTW' do
      @company.valid?
      # now it shoud be geocoded, that is, have lat and long set:

      expect(@company.longitude).to eq 13.5261362
      expect(@company.latitude).to eq 52.4577228

    end

    it 'geocodes IS24' do
      @is24.valid?
      # now it shoud be geocoded, that is, have lat and long set:

      expect(@is24.longitude).to eq 13.4313378
      expect(@is24.latitude).to eq 52.5124602

    end
  end

end

# to try it out in rails console:


# Geocoder.configure(:timeout => 100)
# Geocoder.search("Wilhelminenhofstr. 75 A, 12459, Berlin, Germany")
