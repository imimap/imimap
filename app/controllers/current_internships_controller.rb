class CurrentInternshipsController < ApplicationController
before_filter :authorize, :auth_PV



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

	#def auth_PV
	#	if ((!current_user.superuser) && (!(current_user.email == "s0553728@htw-berlin.de")))
	#		redirect_to overview_index_path
	#	end
	#end

def auth_PV

	#email = ["s0553728@htw-berlin.de", "s0538144@htw-berlin.de"]

	#if  (current_user.student_id == nil?)
	#		redirect_to overview_index_path
	#	end

	#if  (current_user.email != email))
	#	redirect_to overview_index_path
	#end


end

end
