# frozen_string_literal: true

Geocoder.configure(lookup: :test)
Geocoder::Lookup::Test.add_stub(
  'Wilhelminenhofstr. 75 A, 12459 Berlin, Germany', [
    {
      'coordinates'  => [52.4565551, 13.5261029],
      'address'      => 'HTW Berlin, Campus Wilhelminenhof, Geb. C (Computermuseum), 75 A, Wilhelminenhofstraße, Oberschöneweide, Treptow-Köpenick, Berlin, 12459, Germany',
      'state'        => 'Berlin',
      'state_code'   => 'Berlin',
      'country'      => 'Germany',
      'country_code' => 'de'
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  '2454 Telegraph Avenue, 94704 Berkeley, USA', [
    {
      'coordinates'  => [37.8658222196983, -122.25877850794],
      'address'      => '2454, Telegraph Avenue, Southside, Berkeley, Alameda County, California, 94704, USA',
      'post_code' => '94704',
      'state'        => 'California',
      'state_code'   => 'CA',
      'country'      => 'USA',
      'country_code' => 'us'
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  'Karl-Marx-Straße 267, 12057 Berlin, Germany', [
    {
      'coordinates'  => [52.4652723, 13.4430158],
      'address'      => 'Shell, 267, Karl-Marx-Straße, Richardkiez, Neukölln, Berlin, 12057, Germany',
      'post_code' => '12057',
      'state'        => 'Berlin',
      'state_code'   => 'Berlin',
      'country'      => 'Germany',
      'country_code' => 'de'
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  'Andreasstr. 10, 10243 Berlin, Germany', [
    {
      'coordinates'  => [52.5119111, 13.4311331],
      'address'      => 'Sozialhelden e.V., 10, Andreasstraße, Fhain, Friedrichshain-Kreuzberg, Berlin, 10243, Germany',
      'post_code' => '10243',
      'state'        => 'Berlin',
      'state_code'   => 'Berlin',
      'country'      => 'Germany',
      'country_code' => 'de'
    }
  ]
)



# Geocoder.search("Wilhelminenhofstr. 75 A, 12459 Berlin, Germany")
