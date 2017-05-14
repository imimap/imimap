require 'rails_helper'

describe "how we expect to use the geocoder gem" do
  # http://www.rubygeocoder.com
  # https://github.com/alexreisner/geocoder
  before :each do
    @company = build :company
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
  end

end

# to try it out in rails console:
# require 'geocoder'
# Geocoder.configure(:timeout => 100)
# Geocoder.search("Wilhelminenhofstr. 75 A, 12459, Berlin, Germany")

# this was the result:
# [#<Geocoder::Result::Google:0x007fcc345c41c8 @data={"address_components"=>[{"long_name"=>"75", "short_name"=>"75", "types"=>["street_number"]}, {"long_name"=>"Wilhelminenhofstraße", "short_name"=>"Wilhelminenhofstraße", "types"=>["route"]}, {"long_name"=>"Bezirk Treptow-Köpenick", "short_name"=>"Bezirk Treptow-Köpenick", "types"=>["political", "sublocality", "sublocality_level_1"]}, {"long_name"=>"Berlin", "short_name"=>"Berlin", "types"=>["locality", "political"]}, {"long_name"=>"Berlin", "short_name"=>"Berlin", "types"=>["administrative_area_level_1", "political"]}, {"long_name"=>"Germany", "short_name"=>"DE", "types"=>["country", "political"]}, {"long_name"=>"12459", "short_name"=>"12459", "types"=>["postal_code"]}], "formatted_address"=>"Wilhelminenhofstraße 75, 12459 Berlin, Germany", "geometry"=>{"location"=>{"lat"=>52.4577228, "lng"=>13.5261362}, "location_type"=>"ROOFTOP", "viewport"=>{"northeast"=>{"lat"=>52.4590717802915, "lng"=>13.5274851802915}, "southwest"=>{"lat"=>52.4563738197085, "lng"=>13.5247872197085}}}, "partial_match"=>true, "place_id"=>"ChIJURML071IqEcRjWCrNcDiMbs", "types"=>["street_address"]}, @cache_hit=nil>, #<Geocoder::Result::Google:0x007fcc345cee48 @data={"address_components"=>[{"long_name"=>"HTW Berlin - Gebäude C", "short_name"=>"HTW Berlin - Gebäude C", "types"=>["premise"]}, {"long_name"=>"75A", "short_name"=>"75A", "types"=>["street_number"]}, {"long_name"=>"Wilhelminenhofstraße", "short_name"=>"Wilhelminenhofstraße", "types"=>["route"]}, {"long_name"=>"Bezirk Treptow-Köpenick", "short_name"=>"Bezirk Treptow-Köpenick", "types"=>["political", "sublocality", "sublocality_level_1"]}, {"long_name"=>"Berlin", "short_name"=>"Berlin", "types"=>["locality", "political"]}, {"long_name"=>"Berlin", "short_name"=>"Berlin", "types"=>["administrative_area_level_1", "political"]}, {"long_name"=>"Germany", "short_name"=>"DE", "types"=>["country", "political"]}, {"long_name"=>"12459", "short_name"=>"12459", "types"=>["postal_code"]}], "formatted_address"=>"HTW Berlin - Gebäude C, Wilhelminenhofstraße 75A, 12459 Berlin, Germany", "geometry"=>{"bounds"=>{"northeast"=>{"lat"=>52.4577058, "lng"=>13.5273674}, "southwest"=>{"lat"=>52.4561565, "lng"=>13.5255202}}, "location"=>{"lat"=>52.4571102, "lng"=>13.5267022}, "location_type"=>"ROOFTOP", "viewport"=>{"northeast"=>{"lat"=>52.4582801302915, "lng"=>13.5277927802915}, "southwest"=>{"lat"=>52.4555821697085, "lng"=>13.5250948197085}}}, "partial_match"=>true, "place_id"=>"ChIJJ5FEtr1IqEcR1ZFuchYijY4", "types"=>["premise"]}, @cache_hit=nil>]
