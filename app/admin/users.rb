# frozen_string_literal: true

ActiveAdmin.register User do
  menu parent: 'data_admin', priority: 2
  permit_params User::EDITABLE_ATTRIBUTES_ALL + [:student_id]

  controller do
    def update
      if params[:user][:feature_toggles]

        params[:user][:feature_toggles] = params[:user][:feature_toggles]
                                          .reject(&:empty?)
                                          .map(&:to_sym)
                                          .join(',')
      end
      if params[:user][:password].blank? &&
         params[:user][:password_confirmation].blank?
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
      features = FT.list.map do |ft|
        [ft.to_s, ft, { checked: f.object.feature_on?(ft) }]
      end
      f.input :feature_toggles, as: :check_boxes, collection: features
    end

    f.inputs 'Password' do
      User::EDITABLE_ATTRIBUTES_PW.each do |a|
        f.input a
      end
    end
    f.actions
  end
end
