ActiveAdmin.register Invitation do
  menu priority: 6

  permit_params :business_id, :manager_id, :name, allowed_email_attributes: [
    :email, :name, :role, :position_id, allowed_facility_ids: []
  ]

  actions :index, :show, :destroy

  config.sort_order = 'created_at_asc'
  includes :manager, :allowed_email

  config.filters = false

  index do
    column(:email) { |invitation| invitation.allowed_email.email }
    column(:name) { |invitation| invitation.allowed_email.name }
    column(:role) { |invitation| invitation.allowed_email.role }
    column :status
    column(:position) { |invitation| invitation.allowed_email.position }
    column(:manager) { |invitation| invitation.manager.email }
    column(:allowed_facilities) do |invitation|
      invitation.allowed_email.allowed_facilities.pluck(:name).sort.join(', ')
    end
    column :token
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :status
      row :position
      row :manager
      row(:allowed_facilities) do |invitation|
        invitation.allowed_email.allowed_facilities.pluck(:name).sort.join(', ')
      end
      row :token
      row :created_at
    end
  end
end
