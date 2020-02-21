class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere
  routing  :all=> :offers
  # routing  /test@htw-berlin.de/i => :offers
  # routing  /testing@htw-berlin.de/i => :delete
end
