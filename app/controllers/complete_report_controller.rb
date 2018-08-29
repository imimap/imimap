# frozen_string_literal: true

class CompleteReportController < ApplicationResourceController
  respond_to :html, :json
  before_action :authorize_role_prof

  def index
    @internships = Internship.where(report_state_id: ReportState.second, semester_id: Semester.first)

    respond_to do |format|
      format.html
      format.csv { send_data @internships.to_csv }
      format.xls { send_data @internships.to_csv(col_sep: "\t") }
    end
  end
end
