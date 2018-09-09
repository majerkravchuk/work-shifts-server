ActiveAdmin.register BusinessAudit do
  menu priority: 9, label: 'Audit', if: -> { current_user.super_admin? }

  config.sort_order = 'created_at_desc'
  actions :index, :show

  config.filters = false

  index do
    column(:user) { |resource| resource.username }
    column(:auditable) { |resource| resource.auditable_type }
    column :action
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :user_id
      row :user_type
      row :username
      row :auditable_id
      row :associated_id
      row :auditable_type
      row(:audited_changes) { |resource| pre JSON.pretty_generate(resource.audited_changes.as_json) }
      row :action
      row :associated_type
      row :remote_address
      row :request_uuid
      row :version
      row :created_at
    end
  end
end
