# frozen_string_literal: true

# Helper Methods for Internship stuff
module InternshipsHelper
  # used to show the url with protocol
  def url_with_protocol(url)
    /^http/.match?(url) ? url : "http://#{url}"
  end

  def link_to_add_fields(name, field, association)
    new_object = field.object.send(association).klass.new
    id = new_object.object_id
    fields = field.fields_for(association,
                              new_object,
                              child_index: id) do |builder|
      render(association.to_s.singularize + '_fields', f: builder)
    end
    link_to(" #{name}",
            '#',
            class: 'add_fields btn btn-success icon-white icon-plus',
            data: { id: id, fields: fields.delete("\n") })
  end
end
