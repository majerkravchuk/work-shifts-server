ActiveAdmin.register Administrator do
  menu parent: 'Users', priority: 1, if: -> { current_user.administrator? && current_user.super_administrator? }

  permit_params :name, :email, :business_id, :password, :password_confirmation

  config.sort_order = 'name_asc'

  controller do
    def update
      if params[:manager][:password].blank? && params[:manager][:password_confirmation].blank?
        params[:manager].delete('password')
        params[:manager].delete('password_confirmation')
      end
      super
    end
  end

  member_action :reset_password, method: :post do
    resource.send_reset_password_instructions
    redirect_to admin_administrators_path, notice: 'The instruction for password recovery was successfully sent.'
  end

  filter :name
  filter :email
  filter :created_at

  index do
    column :name
    column :email
    column :created_at
    actions defaults: true do |manager|
      link_to 'Reset password', reset_password_admin_administrator_path(manager), method: :post
    end
  end

  show do
    attributes_table do
      row :name
      row :email
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
