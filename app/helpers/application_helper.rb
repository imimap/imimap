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
                       params.permit(%i[locale internship_id company_id])
                             .merge(locale: loc)
                     end
      concat content_tag(:li, (link_to_unless_current loc, locale_param),
                         class: "locale-#{loc}")
    end
  end

  # form helper that adds a label_class to the bootstrap_form field. see #402
  def required_application(form, field, options = {})
    required_application_impl(form, field, :label_class, options)
  end

  def required_application_impl(form, field, css_class, options = {})
    model = form.object.class
    if model.attributes_required_for_internship_application.include? field
      options.merge!(css_class => 'required_application')
    end
    options
  end

  def required_save_and_application(form, field, options = {})
    model = form.object.class
    if model.attributes_required_for_save.include? field
      options.merge!(class: 'required')
    end
    byebug
    required_application_impl(form, field, :class, options)
  end
end
