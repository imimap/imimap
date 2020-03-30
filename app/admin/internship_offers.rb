# frozen_string_literal: true

ActiveAdmin.register InternshipOffer do
  menu parent: 'imimap', priority: 8
  # permit_params InternshipOffersController.permitted_params
  permit_params :title, :body, :created_at, :updated_at, :city, :country, 
  :active, :user_id, :pdf

   filter :user_id , as: :select, collection: proc { User.all }
   filter :title 
   filter :created_at
   filter :city 
   filter :country
   filter :active

  form do |f|
    f.inputs 'Internship Offers' do
      f.input :user_id, :as => :select, :collection => User.all
      f.input :title
      f.label "Description", :class => "description"
      f.rich_text_area :body, as: :action_text
      f.input :city
      f.input :country, as: :string
      f.input :active
      f.input :pdf, as: :file
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :user
    column :title
    # column (:body) { |post| raw(post.body)}
    column :city
    column :country
    column :created_at
    column :updated_at
    column :active
    column :pdf
    actions
  end

  show do |internship_offer|
    attributes_table do
      row :user
      row :title
      row (:body) { |post| raw(post.body)}
      row :city
      row :created_at
      row :updated_at
      row :country
      row :active
      row :pdf
    end
    active_admin_comments
  end


   
  #  Action mailer send
   after_save do |internship|
    if internship.active == true
      InternshipOfferMailer.new_internship_offer(internship).deliver_now
    end
   end
end
