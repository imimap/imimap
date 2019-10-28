class AddApprovedToInternship < ActiveRecord::Migration[6.0]
  def change
    add_column :internships, :approved, :boolean, default: false
  end
end

# 20190913122135 AddFeatureTogglesToUser
# 20191022132522 AddDefaultsForAepPassedInCompleteInternship
# 20191027203648 CreateUserCanSeeCompanies
