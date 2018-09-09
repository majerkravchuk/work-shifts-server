ActiveAdmin.register User::Worker, as: 'Manager' do
  menu parent: 'Users', priority: 3, if: -> { current_user.admin? }

  includes :position

  permit_params :name, :email, :business_id, :position_id, :password, :password_confirmation, facility_ids: []

  config.sort_order = 'name_asc'

  controller do
    def scoped_collection
      end_of_association_chain.joins(:position)
                              .where(positions: { type: 'Position::Manager' })
                              .not_in_inviting_process
                              .distinct
    end

    def create
      params[:user_worker][:business_id] = current_business.id
      create! { admin_managers_path }
    end

    def update
      if params[:user_worker][:password].blank? && params[:user_worker][:password_confirmation].blank?
        params[:user_worker].delete('password')
        params[:user_worker].delete('password_confirmation')
      end
      update! do |format|
        format.html { redirect_to send("admin_#{resource.role.pluralize}_path") }
      end
    end
  end

  member_action :reset_password, method: :post do
    resource.send_reset_password_instructions
    redirect_to admin_managers_path, notice: 'The instruction for password recovery was successfully sent.'
  end

  filter :name
  filter :email
  filter :position, as: :select, collection: proc { current_business.manager_positions }
  filter :created_at

  index do
    column :name
    column :email
    column(:position) { |resource| resource.position.name.capitalize }
    column :created_at
    actions defaults: true do |resource|
      link_to 'Reset password', reset_password_admin_manager_path(resource), method: :post
    end
  end

  show do
    attributes_table do
      row :name
      row :email
      row(:position) { |resource| resource.position.name.capitalize }
      row :created_at
    end
  end

  form do |f|
    generator = ActiveAdmin::UserFormGenerator.new(current_user, current_business, f.object, :manager)
    form_proc = generator.generate_form_proc
    form_proc.call(f)
  end
end
