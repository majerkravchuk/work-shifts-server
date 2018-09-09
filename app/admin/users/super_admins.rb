ActiveAdmin.register User::SuperAdmin, as: 'SuperAdmin' do
  menu parent: 'Users', priority: 1, if: -> { current_user.super_admin? }

  permit_params :name, :email, :password, :password_confirmation

  config.sort_order = 'name_asc'

  controller do
    def scoped_collection
      end_of_association_chain.not_in_inviting_process
    end

    def create
      create!{ admin_super_admins_path }
    end

    def update
      if params[:user_super_admin][:password].blank? && params[:user_super_admin][:password_confirmation].blank?
        params[:user_super_admin].delete('password')
        params[:user_super_admin].delete('password_confirmation')
      end
      update!{ admin_super_admins_path }
    end
  end

  member_action :reset_password, method: :post do
    resource.send_reset_password_instructions
    redirect_to admin_super_admins_path, notice: 'The instruction for password recovery was successfully sent.'
  end

  filter :name
  filter :email
  filter :created_at

  index do
    column :name
    column :email
    column :created_at
    actions defaults: true do |manager|
      link_to 'Reset password', reset_password_admin_super_admin_path(manager), method: :post
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
    generator = ActiveAdmin::UserFormGenerator.new(current_user, current_business, f.object, :super_admin)
    form_proc = generator.generate_form_proc
    form_proc.call(f)
  end
end
