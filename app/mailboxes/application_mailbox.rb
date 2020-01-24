class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere
  routing  :all => :offers
  # routing OffersMailbox::MATCHER => :offers
end
