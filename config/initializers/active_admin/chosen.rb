# frozen_string_literal: true

# TBD is this still needed?
module ActiveAdmin
  module Inputs
    class FilterSelectInput < ::Formtastic::Inputs::SelectInput
      def extra_input_html_options
        {
          class: 'chosen'
        }
      end
    end
  end
end

module Formtastic
  module Inputs
    class SelectInput
      def extra_input_html_options
        { class: 'chosen',
          multiple: multiple? }
      end
    end
  end
end
