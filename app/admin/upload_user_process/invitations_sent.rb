ActiveAdmin.register User, as: 'InvitationsSent' do
  menu label: 'Invitations sent', parent: 'Upload user process', priority: 3

  actions :index, :show, :destroy

  config.sort_order = 'email_asc'
  includes :position

  controller do
    def scoped_collection
      end_of_association_chain.where(invitation_status: :invited)
    end
  end

  index do
    selectable_column
    column :email
    column :name
    column(:role) { |resource| resource.type.split('::').last }
    column :invitation_status
    column :position
    column(:facilities) { |user| user.employee? ? user.facilities.pluck(:name).sort.join(', ') : '' }
    actions
  end

  filter :email
  filter :name
  filter :position,
         as: :select,
         collection: proc { current_business.positions.order(:name) }

  show do
    attributes_table do
      row :email
      row :name
      row :position
      row(:facilities) { |user| user.facilities.pluck(:name).sort.join(', ') } if resource.employee?
      row :created_at
    end
  end

#   form do |f|
#     f.inputs do
#       input_html = {}.tap do |p|
#         p[:autocomplete] = :off
#         p[:readonly] = !f.object.new_record?
#         p[:disabled] = !f.object.new_record?
#       end
#       f.input :email, input_html: input_html
#
#       f.input :name
#
#       if current_user.administrator?
#         f.input :role,
#                 as: :select,
#                 collection: [['Employee', :employee], ['Manager', :manager]],
#                 include_blank: false
#       end
#
#       positions_collection = current_business.positions.order(:name).map do |position|
#         if position.is_a?(ManagerPosition) && !current_user.administrator?
#           nil
#         elsif current_user.employee_positions.exclude?(position) && !current_user.administrator?
#           nil
#         else
#           [position.name, position.id, {
#             class: position.type.underscore.gsub('_', '-'),
#             hidden: position.is_a?(ManagerPosition)
#           }]
#         end
#       end
#       f.input :position,
#               as: :select,
#               collection: positions_collection.compact,
#               include_blank: false
#
#       collected_data = current_business.facilities.order(:name).map do |facility|
#         [facility.name, facility.id, { checked: f.object.facilities.include?(facility) }]
#       end
#       f.input :facilities,
#               as: :check_boxes,
#               collection: collected_data
#     end
#     f.actions
#   end
end
