class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere
#  routing  :all=> :offers
  routing  /add_offer@htw-berlin.de/i => :add_offers
  routing  /delete_offer@htw-berlin.de/i => :delete_offers
end
