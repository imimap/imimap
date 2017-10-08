class CurrentInternshipsController < ApplicationController
before_filter :auth_PV #:authorize,



	def index
		@semester = Semester.last
		@internships = Internship.where(semester_id: @semester)
		@companies = Company.all
		@semesters = Semester.all

		respond_to do |format|
			format.html
			format.csv {send_data @internships.to_csv}
		end
	end

	def auth_PV
		if ((!current_user.superuser) && (!(current_user.email == Rails.configuration.x.pv_Email)))
			redirect_to overview_index_path
		end
	end

end
