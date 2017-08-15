class CompleteReportController < ApplicationController
  respond_to :html, :json
  before_filter :authorize



  def index

    @internships = Internship.where(report_state_id: ReportState.second, semester_id: Semester.first)


    respond_to do |format|
      format.html
      format.csv {send_data @internships.to_csv}
      format.xls { send_data @internships.to_csv(col_sep: "\t") }
    end


  end



end