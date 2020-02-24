class SearchesController < InheritedResources::Base
  load_and_authorize_resource

  def start_search
    @search = Search.new
  end

  private

    def search_params
      params.require(:search).permit()
    end

end
