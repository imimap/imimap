class FinishReadsController < InheritedResources::Base

  private

    def finish_read_params
      params.require(:finish_read).permit(:user_id, :internship_id)
    end
end

