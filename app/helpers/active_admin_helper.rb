# frozen_string_literal: true

# Helper Methods for all ActiveAdmin Views.
# They need to be included in the needed classes
# as below.
module ActiveAdminHelper
  def link_to_list(internships)
    links = internships.map do |internship|
      internship_id = internship.id
      link_to internship_id, admin_internship_path(internship_id)
    end
    links.join(', ').html_safe
  end

  def link_id(model)
    "#{model.class}_#{model.id}"
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
