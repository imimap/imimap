# frozen_string_literal: true

module UrlHelper
  def url_with_protocol(url)
    /^http/.match?(url) ? url : "http://#{url}"
  end
end
module ApplicationHelper
  include UrlHelper

  def render_stars(rating, template)
    RatingRenderer.new(rating, template).render_star_fields
  end

  def flash_class(level)
    case level
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-danger'
    when :alert then 'alert alert-info'
    end
  end

  def link_to_add_fields(name, field, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = field.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + '_fields', f: builder)
    end
    link_to(" #{name}", '#', class: 'add_fields btn btn-success icon-white icon-plus', data: { id: id, fields: fields.delete("\n") })
  end

  def notifications
    Notification.where(user_id: current_user.try(:id)).order('created_at DESC')
  end

  def locale_picker
    I18n.available_locales.each do |loc|
      # CodeReviewSS17
      # this seems to be a necessary workaround because of the current
      # url structure, maybe adapt the routes/paths?
      locale_param = request.path == root_path ? root_path(locale: loc) : params.permit(:locale).merge(locale: loc)
      concat content_tag(:li, (link_to_unless_current loc, locale_param), class: "locale-#{loc}")
    end
  end
end
