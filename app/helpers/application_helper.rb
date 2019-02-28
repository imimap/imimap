# frozen_string_literal: true

# View Helper Methods for all Controllers.
module ApplicationHelper
  def semester_from_params(params)
    if params && params['semester_id']
      Semester.find(params['semester_id'])
    else
      Semester.current
    end
  end

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

  def notifications
    Notification.where(user_id: current_user.try(:id)).order('created_at DESC')
  end

  def locale_picker
    I18n.available_locales.each do |loc|
      # CodeReviewSS17
      # this seems to be a necessary workaround because of the current
      # url structure, maybe adapt the routes/paths?
      locale_param = if request.path == root_path
                       root_path(locale: loc)
                     else
                       params.permit(:locale).merge(locale: loc)
                     end
      concat content_tag(:li, (link_to_unless_current loc, locale_param),
                         class: "locale-#{loc}")
    end
  end
end
