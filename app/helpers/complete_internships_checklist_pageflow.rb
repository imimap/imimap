# frozen_string_literal: true

# link helpers for all views involved in the checklist pageflow
# context to the complete_internship checklist
# is maintained by passing a 'cidcontext' parameter holding the
# complete_internship id.
module CompleteInternshipsChecklistPageflow
  def set_checklist_context(params:, resource: nil)
    @cidcontext = cidcontext_from(params: params, resource: resource)

    # raise ArgumentError, 'no complete_internship_id found'
  end

  def checklist_hidden_form_fields(form:, params:, resource: nil)
    form.hidden_field(:cidcontext,
                      value: cidcontext_from(
                        params: params, resource: resource
                      ))
  end

  def checklist_back_to_overview_link(params: {}, resource: nil)
    cid = cidcontext_from(params: params, resource: resource)
    if cid.nil?
      'no cid'
    else
      link_to t('buttons.back_to_overview'),
              complete_internship_path(cid)
    end
  end

  private

  def cidcontext_from(params:, resource: nil)
    params && params[:cidcontext] \
    || resource && params[resource] && params[resource][:cidcontext] \
    || nil
  end
end
