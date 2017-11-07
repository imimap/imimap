class UserCommentsController < ApplicationController

  # GET /companies/new
  # GET /companies/new.json

  def new
    @comment = UserComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end



  def create
    @comment = UserComment.new(user_comment_params)
    @comment.user_id = current_user.id if current_user
    @comment.save
    @answer = Answer.new
    #flash[:notice] = "UserComment was successfully created" if @comment.save
    @internship = @comment.internship
    @user_comments = @internship.user_comments.order("created_at DESC")
    @new_comment = UserComment.new

    respond_to do |format|
      format.js { render :layout=> false, :locals => { :internship => @internship } }
    end


  end

  def update
    @comment = UserComment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(user_comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = UserComment.find(params[:id])
    @internship = @comment.internship
    @comment.destroy
    #flash[:notice] = "UserComment was successfully deleted"
    @user_comments = @internship.user_comments.order("created_at DESC")
    @new_comment = UserComment.new
    @answer = Answer.new

    respond_to do |format|
      format.js { render :layout=> false, :locals => { :internship => @internship }}
    end
  end

  def user_comment_params
    params.require(:user_comment).permit(:body, :user_id, :internship_id)
  end

end
