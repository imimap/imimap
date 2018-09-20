# Country select

Imimap uses country_select indirectly via active admin and formtastic.
Since Country Select 2 countries are stored in a 2 Digit-Code.

https://github.com/stefanpenner/country_select/blob/master/UPGRADING.md


Migration: see
lib/tasks/temporary/migrate_country_codes.rake



not found United States =>
not found United Kingdom =>
not found Czech Republic =>

GB - United Kingdom of Great Britain and Northern Ireland
US - United States of America
CZ - Czechia


{'United States': 'US'
'United Kingdom': 'GB'
'Czech Republic': 'CZ'}
GB - United Kingdom of Great Britain
US - United States of America
CZ - Czechia


irb(main):006:0>  ISO3166::Country.codes.map { |c| [c, ISO3166::Country.new(c).name] }.each {|c,cou| puts "#{c} - #{cou}"}; nil
TJ - Tajikistan
JM - Jamaica
HT - Haiti
ST - Sao Tome and Principe
MS - Montserrat
AE - United Arab Emirates
PK - Pakistan
NL - Netherlands
LU - Luxembourg
BZ - Belize
IR - Iran (Islamic Republic of)
BO - Bolivia (Plurinational State of)
UY - Uruguay
GH - Ghana
SA - Saudi Arabia
CI - Côte d'Ivoire
MF - Saint Martin (French part)
TF - French Southern Territories
AI - Anguilla
QA - Qatar
SX - Sint Maarten (Dutch part)
LY - Libya
BV - Bouvet Island
PG - Papua New Guinea
KG - Kyrgyzstan
GQ - Equatorial Guinea
EH - Western Sahara
NU - Niue
PR - Puerto Rico
GD - Grenada
KR - Korea (Republic of)
HM - Heard Island and McDonald Islands
SM - San Marino
SL - Sierra Leone
CD - Congo (Democratic Republic of the)
MK - Macedonia (the former Yugoslav Republic of)
TR - Turkey
DZ - Algeria
GE - Georgia
PS - Palestine, State of
BB - Barbados
UA - Ukraine
GP - Guadeloupe
PF - French Polynesia
NA - Namibia
BW - Botswana
SY - Syrian Arab Republic
TG - Togo
DO - Dominican Republic
AQ - Antarctica
CH - Switzerland
MG - Madagascar
FO - Faroe Islands
VG - Virgin Islands (British)
GI - Gibraltar
BN - Brunei Darussalam
LA - Lao People's Democratic Republic
IS - Iceland
EE - Estonia
UM - United States Minor Outlying Islands
LT - Lithuania
RS - Serbia
MR - Mauritania
AD - Andorra
HU - Hungary
TK - Tokelau
MY - Malaysia
AO - Angola
CV - Cabo Verde
NF - Norfolk Island
PA - Panama
GW - Guinea-Bissau
BE - Belgium
PT - Portugal
GB - United Kingdom of Great Britain and Northern Ireland
IM - Isle of Man
US - United States of America
YE - Yemen
HK - Hong Kong
AZ - Azerbaijan
CC - Cocos (Keeling) Islands
ML - Mali
SK - Slovakia
VU - Vanuatu
TL - Timor-Leste
HR - Croatia
SR - Suriname
MU - Mauritius
CZ - Czechia
PM - Saint Pierre and Miquelon
LS - Lesotho
WS - Samoa
KM - Comoros
IT - Italy
BI - Burundi
WF - Wallis and Futuna
GN - Guinea
SG - Singapore
CO - Colombia
CN - China
AW - Aruba
MA - Morocco
FI - Finland
VA - Holy See
ZW - Zimbabwe
KY - Cayman Islands
BH - Bahrain
PY - Paraguay
EC - Ecuador
LR - Liberia
RU - Russian Federation
PL - Poland
OM - Oman
MT - Malta
SS - South Sudan
DE - Germany
TM - Turkmenistan
SJ - Svalbard and Jan Mayen
MM - Myanmar
TT - Trinidad and Tobago
IL - Israel
BD - Bangladesh
NR - Nauru
LK - Sri Lanka
UG - Uganda
NG - Nigeria
BQ - Bonaire, Sint Eustatius and Saba
MX - Mexico
CW - Curaçao
SI - Slovenia
MN - Mongolia
CA - Canada
AX - Åland Islands
VN - Viet Nam
TW - Taiwan, Province of China
JP - Japan
IO - British Indian Ocean Territory
RO - Romania
BG - Bulgaria
GU - Guam
BR - Brazil
AM - Armenia
ZM - Zambia
DJ - Djibouti
JE - Jersey
AT - Austria
CM - Cameroon
SE - Sweden
FJ - Fiji
KZ - Kazakhstan
GL - Greenland
GY - Guyana
CX - Christmas Island
MW - Malawi
TN - Tunisia
ZA - South Africa
TO - Tonga
CY - Cyprus
MV - Maldives
PN - Pitcairn
RW - Rwanda
NI - Nicaragua
KN - Saint Kitts and Nevis
BJ - Benin
ET - Ethiopia
GM - Gambia
TZ - Tanzania, United Republic of
VC - Saint Vincent and the Grenadines
FK - Falkland Islands (Malvinas)
SD - Sudan
MC - Monaco
AU - Australia
CL - Chile
DK - Denmark
FR - France
TC - Turks and Caicos Islands
CU - Cuba
AL - Albania
MZ - Mozambique
BS - Bahamas
NE - Niger
GT - Guatemala
LI - Liechtenstein
NP - Nepal
BF - Burkina Faso
PW - Palau
KW - Kuwait
IN - India
GA - Gabon
TV - Tuvalu
MO - Macao
SH - Saint Helena, Ascension and Tristan da Cunha
MD - Moldova (Republic of)
CK - Cook Islands
AR - Argentina
SC - Seychelles
IE - Ireland
ES - Spain
LB - Lebanon
BM - Bermuda
RE - Réunion
KI - Kiribati
AG - Antigua and Barbuda
MQ - Martinique
SV - El Salvador
JO - Jordan
TH - Thailand
SO - Somalia
MH - Marshall Islands
CG - Congo
KP - Korea (Democratic People's Republic of)
GF - French Guiana
BA - Bosnia and Herzegovina
YT - Mayotte
GS - South Georgia and the South Sandwich Islands
KE - Kenya
PE - Peru
BT - Bhutan
SZ - Swaziland
CR - Costa Rica
TD - Chad
DM - Dominica
NC - New Caledonia
GR - Greece
GG - Guernsey
HN - Honduras
VI - Virgin Islands (U.S.)
CF - Central African Republic
SN - Senegal
AF - Afghanistan
MP - Northern Mariana Islands
PH - Philippines
BY - Belarus
LV - Latvia
NO - Norway
EG - Egypt
KH - Cambodia
IQ - Iraq
LC - Saint Lucia
NZ - New Zealand
BL - Saint Barthélemy
UZ - Uzbekistan
ID - Indonesia
ER - Eritrea
VE - Venezuela (Bolivarian Republic of)
FM - Micronesia (Federated States of)
SB - Solomon Islands
ME - Montenegro
AS - American Samoa
=> nil
