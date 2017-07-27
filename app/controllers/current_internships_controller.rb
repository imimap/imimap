class CurrentInternshipsController < ApplicationController

	def index
		@internships = Internship.where(semester_id: 6)
		@companies = Company.all
		@semesters = Semester.all

		respond_to do |format|
			format.html
			format.csv {send_data @internships.to_csv}
		end
	end
end
