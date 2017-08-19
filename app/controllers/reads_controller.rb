class ReadsController < InheritedResources::Base

  before_filter :authorize, :redirect_PV

  def create

    @read = Read.new
    @read.internship_id = params[:internship_id]
    @read.user_id = params[:user_id]
    @read.save

    @current_user = @read.user
    @internship = @read.internship

    respond_to do |format|
      format.js { render :layout=>false,:locals => { :current_user  => @current_user, :internship => @internship, :read => @read} }
    end
  end

  def destroy
    @read = Read.find(params[:id])
    @current_user = @read.user
    @internship = @read.internship
    @read.destroy

    respond_to do |format|
      format.html { redirect_to(favorite_index_path) }
      format.js { render :layout=>false,:locals => { :current_user  => @current_user, :internship => @internship, :read => @read} }
    end
  end

  def index

    @reads = current_user.reads

  end

end


