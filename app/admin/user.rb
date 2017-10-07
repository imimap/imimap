#CodeReviewSS17 why was this file renamed from users.rb to user.rb?

ActiveAdmin.register User do

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :superuser, :label => "Super Administrator"
    end
    actions
  end

  create_or_edit = Proc.new {
    @user            = User.find_or_create_by(params[:id])
    @user.superuser = params[:user][:superuser]
    @user.attributes = params[:user].delete_if do |k, v|
      (k == "superuser") ||
          (["password", "password_confirmation"].include?(k) && v.empty? && !@user.new_record?)
    end
    if @user.save
      redirect_to :action => :show, :id => @user.id
    else
      render active_admin_template((@user.new_record? ? 'new' : 'edit') + '.html.erb')
    end
  }
  member_action :create, :method => :post, &create_or_edit
  member_action :update, :method => :put, &create_or_edit

end
