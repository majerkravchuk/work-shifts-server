ActiveAdmin.register BusinessAudit do
  menu priority: 9, label: 'Audit'

  config.sort_order = 'created_at_desc'
  actions :index, :show

  config.filters = false

  index do
    column(:user) { |audit| audit.username }
    column(:auditable) do |audit|
      record = audit.auditable_type.constantize.find_by(id: audit.auditable_id)
      if record.is_a?(EmailLoader::Result)
        link_to 'EmailLoader::Result', admin_emails_from_file_path(result_id: record.id)
      elsif record.present?
        begin
          link_to record.class.name, send("admin_#{record.class.name.underscore}_path", record.id)
        rescue
          record.class.name
        end
      else
        audit.auditable_type
      end
    end
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
      row :audited_changes
      row :action
      row :associated_type
      row :remote_address
      row :request_uuid
      row :version
      row :created_at
    end
  end
end
