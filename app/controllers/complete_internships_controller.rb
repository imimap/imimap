class CompleteInternshipsController < InheritedResources::Base

  private

    def complete_internship_params
      params.require(:complete_internship).permit(:semester, :semester_of_study, :aep, :passed)
    end
end

