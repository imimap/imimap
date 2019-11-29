# frozen_string_literal: true

# link helpers for all views involved in the checklist pageflow
module CompleteInternshipsChecklistPageflow
  def link_to_student_details(student:)
    link_to t('complete_internships.checklist.personal_details'), student
  end

  def checklist_set_back_params(params:, complete_internship:)
    if params[:complete_internship_id]
      return @complete_internship_id = params[:complete_internship_id]
    end

    ci = complete_internship
    return @complete_internship_id = ci.id if ci
  end

  def checklist_hidden_form_fields(form:)
    form.hidden_field(:complete_internship_id,
                      value: @complete_internship_id)
  end

  def checklist_back_to_overview_link(params: {})
    cid = @complete_internship_id || params && params[:complete_internship_id]
    if cid
      link_to t('buttons.back_to_overview'),
              complete_internship_path(cid)
    else
      ''
    end
  end

  def link_to_internship_details(internship:)
    link_to t('complete_internships.checklist.internship_details'),
            edit_internship_path(internship.id)
  end
end
