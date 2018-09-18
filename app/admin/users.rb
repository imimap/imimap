# frozen_string_literal: true

ActiveAdmin.register User do
  # permit_params User::EDITABLE_ATTRIBUTES_ALL
  form do |f|
    f.inputs 'User Details' do
      User::EDITABLE_ATTRIBUTES.each do |a|
        f.input a
      end
    end
    actions
  end

  # form title: 'Change Password' do |f|
  #   inputs 'Password' do
  #     User::EDITABLE_ATTRIBUTES_PW.each do |a|
  #       f.input a
  #     end
  #   end
  #   actions
  # end
end
