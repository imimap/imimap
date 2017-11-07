class CurrentInternshipsController < ApplicationController

before_action :authorize_role_pruefungsverwaltung

# CodeReviewSS17
# Why is this a special controller? It offers an index view on Internship.

	def index
		# CodeReviewSS17 this will select the randomly last created semester
		# in the database, maybe. Semester needs to be selectable, with the
		# current semester as default.
		@semester = Semester.last
		@internships = Internship.where(semester_id: @semester)
		# CodeReviewSS17 Not used in the view
		@companies = Company.all
		# CodeReviewSS17 Not used in the view
		@semesters = Semester.all

		respond_to do |format|
			format.html
			format.csv {send_data @internships.to_csv}
		end
	end

end
