ActiveAdmin.register User::Worker, as: 'Employee' do
  menu parent: 'Users', priority: 3

  includes profiles: :position

  # permit_params :name, :email, :business_id, :position_id, :password, :password_confirmation, facility_ids: []

  config.sort_order = 'name_asc'

  controller do
    def scoped_collection
      end_of_association_chain.joins(profiles: :position)
                              .where(profiles: { positions: { type: 'Position::Employee' } })
                              .distinct
    end

    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end
      update! do |format|
        format.html { redirect_to send("admin_#{resource.role}_path", resource) }
      end
    end
  end

  member_action :reset_password, method: :post do
    resource.send_reset_password_instructions
    redirect_to admin_employees_path, notice: 'The instruction for password recovery was successfully sent.'
  end

  filter :name
  filter :email
  # filter :position,
  #        as: :select,
  #        collection: proc { current_business.employee_positions }
  # filter :facilities,
  #        as: :select,
  #        collection: proc { current_business.facilities }
  # filter :created_at

  index do
    column :name
    column :email
    column(:position) { |resource| resource.profile(current_business).position.name.capitalize }
    # column(:facilities) do |employee|
    #   employee.facilities.pluck(:name).sort.join(', ')
    # end
    column :created_at
    actions defaults: true do |resource|
      link_to 'Reset password', reset_password_admin_employee_path(resource), method: :post
    end
  end

  show do
    attributes_table do
      row :name
      row :email
      row(:position) { |user| user.profile(current_business).position.name.capitalize }
      # row(:facilities) { |employee| employee.facilities.pluck(:name).sort.join(', ') }
      row :created_at
    end
  end
  #
  # form do |f|
  #   form = ActiveAdmin::UserFormGenerator.new(current_user, current_business, f.object)
  #   form.generate_form_proc.call(f)
  # end
  #
  # # form do |f|
  # #   f.inputs do
  # #     f.input :name
  # #     f.input :email
  # #     f.input :password
  # #     f.input :password_confirmation
  # #     # f.input(:position, {
  # #     #   as: :select,
  # #     #   collection: current_user.employee_positions.map { |p| [p.name.capitalize, p.id] },
  # #     #   include_blank: false
  # #     # })
  # #     collected_data = current_business.facilities.map do |facility|
  # #       [
  # #         facility.name,
  # #         facility.id,
  # #         { checked: f.object.facilities.include?(facility) }
  # #       ]
  # #     end
  # #     f.input :facilities, as: :check_boxes, collection: collected_data
  # #   end
  # #   f.actions
  # # end
end
