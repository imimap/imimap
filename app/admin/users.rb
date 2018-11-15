# frozen_string_literal: true

ActiveAdmin.register User do
  menu priority: 2
  permit_params User::EDITABLE_ATTRIBUTES_ALL

  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end
      super
    end
  end

  index do
    id_column
    column :email
    column :student
    column :publicmail
    column :mailnotif
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'User Details' do
      User::EDITABLE_ATTRIBUTES.each do |a|
        f.input a
      end
    end
    f.inputs 'Password' do
      User::EDITABLE_ATTRIBUTES_PW.each do |a|
        f.input a
      end
    end
    f.actions
  end

end
