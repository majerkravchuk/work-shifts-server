ActiveAdmin.register User::Worker, as: 'Manager' do
  menu parent: 'Users', priority: 2, if: -> { current_user.admin? }

  includes profiles: :position

  # permit_params :name, :email, :business_id, :position_id, :role, :password, :password_confirmation

  config.sort_order = 'name_asc'

  controller do
    def scoped_collection
      end_of_association_chain.joins(profiles: :position)
                              .where(profiles: { positions: { type: 'Position::Manager' } })
                              .distinct
    end
#
#     def create
#       params[:user][:business_id] = current_business.id
#       super
#     end
#
#     def update
#       if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
#         params[:user].delete('password')
#         params[:user].delete('password_confirmation')
#       end
#       update! do |format|
#         format.html { redirect_to send("admin_#{resource.role}_path", resource) }
#       end
#     end
  end
#
#   member_action :reset_password, method: :post do
#     resource.send_reset_password_instructions
#     redirect_to admin_managers_path, notice: 'The instruction for password recovery was successfully sent.'
#   end
#
#   filter :name
#   filter :email
#   filter :position,
#          as: :select,
#          collection: proc { current_business.manager_positions }
#   filter :created_at

  index do
    column :name
    column :email
    column(:position) { |resource| resource.profile(current_business).position.name.capitalize }
    column :created_at
    actions defaults: true do |resource|
      link_to 'Reset password', reset_password_admin_employee_path(resource), method: :post
    end
  end

#   index do
#     column :name
#     column :email
#     column(:position) { |user| user.position.name.capitalize }
#     column :created_at
#     actions defaults: true do |manager|
#       link_to 'Reset password', reset_password_admin_manager_path(manager), method: :post
#     end
#   end
#
  show do
    attributes_table do
      row :name
      row :email
      row(:position) { |resource| resource.profile(current_business).position.name.capitalize }
      row :created_at
    end
  end
#
#   # form do |f|
#   #   generator = ActiveAdmin::UserFormGenerator.new(current_user, current_business, f.object)
#   #   form_proc = generator.generate_form_proc
#   #   form_proc.call(f)
#   # end
#
#   #   f.inputs do
#   #     f.input :name
#   #     f.input :email
#   #     f.input :password
#   #     f.input :password_confirmation
#   #     f.input(:role, {
#   #       collection: { Employee: 'employee', Manager: 'manager' },
#   #       include_blank: false
#   #     })
#   #     f.input(:position, {
#   #       as: :select,
#   #       collection: current_business.manager_positions.order(:name).map { |p| [p.name, p.id] },
#   #       include_blank: false
#   #     })
#   #     collected_data = current_business.facilities.map do |facility|
#   #       [
#   #         facility.name,
#   #         facility.id,
#   #         { checked: f.object.facilities.include?(facility) }
#   #       ]
#   #     end
#   #     f.input :facilities, as: :check_boxes, collection: collected_data
#   #   end
#   #   f.actions
#   # end
end
