class SessionsController < ApplicationController
  layout 'sessions'

  def new
    if current_user
      redirect_to overview_index_url
    end

    @company_location_json = Company.pluck(:name, :latitude, :longitude).to_json.html_safe

  
  @internships = Internship.includes(:company, :semester, :orientation, :programming_languages).where(completed: true).order('created_at DESC')

  @companies = @internships.collect do |i| i.company end
   @pins = Gmaps4rails.build_markers(@companies) do |company, marker |

      n=0
      s=""
      p=""

      @internships_comp = @internships.select {|x| x.company_id == company.id}
      @internships_comp.each do |internship|

      if n==0
        s+=(internship.student.first_name[0..0].capitalize+".")
      else
        s+=(" & " + internship.student.first_name[0..0].capitalize+".")
       end
        n+=1
       end

      if n==1
        p="hat"
      else
        p="haben"
      end


      href =  if company.try(:website).try(:starts_with?,'http') && company
              company.website
              elsif company and company.website
              "http://"+company.website
             end

      marker.infowindow ("<p>#{company.name}</p>")

    end
  end


  def create
    user = User.find_by_email(params[:email])
    #
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to overview_index_url, notice: "Logged in!"
      #if params[:remember_me]
      #  cookies.permanent[:auth_token] = user.auth_token
      #else
      #  cookies[:auth_token] = user.auth_token
      #end
      #redirect_to overview_index_url, :notice => "Logged in!"

    else
      #flash.now.alert = "Email or password is invalid"
      flash[:alert] = t("msg.invalid")

      redirect_to :back
    end
  end

  def destroy
    session[:user_id] = nil
    #cookies.delete(:auth_token)
    redirect_to root_url, :alert =>  t("msg.logout")
  end

 end
