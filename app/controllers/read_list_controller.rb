class ReadListController < ApplicationController

  #check the user if current user nil or not
  before_filter :authorize
  respond_to :html, :json


  # create an unread list and save it
  def create
<<<<<<< HEAD
    @read_list = ReadList.new
=======

    @read_list = ReadList.new

>>>>>>> read list test
    @read_list.internship_id = params[:internship_id]
    @read_list.user_id = params[:user_id]
    @read_list.save

    @current_user = @read_list.user
    @internship = @read_list.internship

    flash[:notice] = "Post successfully created"

    respond_to do |format|
<<<<<<< HEAD
      format.js { render :layout=>false,:locals => { :current_user  => @current_user, :internship => @internship, :read_list => @read_list} }
    end
  end
=======

      format.html { redirect_to(read_list_index_path) }
      format.js { render :layout=>false, :locals => { :current_user  => @current_user, :internship => @internship, :read_list => @read_list} }
>>>>>>> modify search option

  # destroy unwanted assigned reports
  def destroy
    @read_list = ReadList.find(params[:id])
    @current_user = @read_list.user
    @internship = @read_list.internship
    @read_list.destroy

    respond_to do |format|
      format.html { redirect_to(read_list_index_path) }
      format.js { render :layout=>false,:locals => { :current_user  => @current_user, :internship => @internship, :read_list => @read_list} }
    end
  end

<<<<<<< HEAD
<<<<<<< HEAD
  def index

    @read_lists = current_user.read_lists

  end
=======
=======
  def destroy
    @internships = ReadList.find(params[:read_list_ids])
    @internships.map(&:destroy)

    respond_to do |format|
      format.html { redirect_to read_list_index_path }
      format.js { render :layout=>false,:locals => { :current_user  => @current_user, :internship => @internship, :read_list => @read_list} }

    end
  end
>>>>>>> modify delete read list with using checkbox

    # destroy unwanted assigned reports
   # def destroy
       # @read_list = ReadList.find(params[:id])
       # @read_list.destroy


       # @current_user = @read_list.user
       # @internship = @read_list.internship

       # respond_to do |format|
        #    format.html { redirect_to read_list_index_path, notice: 'List successfully deleted'}
         #   format.js { render :layout=>false,:locals => { :current_user  => @current_user, :internship => @internship, :read_list => @read_list} }
   # end
   # end

  def index

       @read_lists = current_user.read_lists

<<<<<<< HEAD
      end
>>>>>>> read list test
=======
  end

  def destroy_multiple

    @read_lists.where(id: params[:read_list_ids]).destroy_all

    respond_to do |format|
      format.html { redirect_to read_list_index_path }
      format.js { render :layout=>false,:locals => { :current_user  => @current_user, :internship => @internship, :read_list => @read_list} }

    end
  end
>>>>>>> modify search option

end
