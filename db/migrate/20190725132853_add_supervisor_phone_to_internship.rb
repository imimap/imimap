class AddSupervisorPhoneToInternship < ActiveRecord::Migration[5.2]
  def change
    add_column :internships, :supervisor_phone, :string
  end
end
