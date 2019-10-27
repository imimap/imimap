# frozen_string_literal: true

# Controller for UserCanSeeCompanies
class UserCanSeeCompaniesController < InheritedResources::Base
  authorize_resource

  private

  def user_can_see_company_params
    params.require(:user_can_see_company).permit(:company_id,
                                                 :user_id,
                                                 :created_by)
  end
end
