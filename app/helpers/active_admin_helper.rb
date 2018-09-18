# frozen_string_literal: true

# Helper Methods for all ActiveAdmin Views.
# They need to be included in the needed classes
# as below.
module ActiveAdminHelper
  def readable_links(a)
    str = ''
    limit = a.count
    counter = 0
    a.each do |x|
      counter += 1
      str += link_to x, "/admin/internships/#{x}"
      str += ', ' if counter < limit
    end
    str.html_safe
  end
end

module ActiveAdmin
  module Views
    # reopen class. this was the only way I found to include a helper
    # in ActiveAdmin
    class IndexAsTable
      include ActiveAdminHelper
    end
    module Pages
      # reopen class. this was the only way I found to include a helper
      # in ActiveAdmin
      class Show
        include ActiveAdminHelper
      end
    end
  end
end
