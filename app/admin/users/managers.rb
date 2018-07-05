ActiveAdmin.register Manager do
  menu parent: 'Users', priority: 2, if: -> { current_user.administrator? }

  includes :position

  permit_params :name, :email, :business_id, :position_id, :password, :password_confirmation

  config.sort_order = 'name_asc'

  controller do
    def create
      params[:manager][:business_id] = current_business.id
      super
    end

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
    redirect_to admin_managers_path, notice: 'The instruction for password recovery was successfully sent.'
  end

  filter :name
  filter :email
  filter :position,
         as: :select,
         collection: proc { ManagerPosition.where(business: current_business) }
  filter :created_at

  index do
    column :name
    column :email
    column(:position) { |user| user.position.name.capitalize }
    column :created_at
    actions defaults: true do |manager|
      link_to 'Reset password', reset_password_admin_manager_path(manager), method: :post
    end
  end

  show do
    attributes_table do
      row :name
      row :email
      row(:position) { |user| user.position.name.capitalize }
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input(:position, {
        as: :select,
        collection: ManagerPosition.where(business: current_business).map { |p| [p.name.capitalize, p.id] },
        include_blank: false
      })
    end
    f.actions
  end
end
