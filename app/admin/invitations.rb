ActiveAdmin.register Invitation do
  menu priority: 6

  actions :index, :show, :destroy

  config.sort_order = 'created_at_asc'
  includes :manager, allowed_email: [:position]

  config.filters = false

  controller do
    def destroy
      resource.allowed_email.update(status: :imported)
      super
    end
  end

  index do
    column(:email) { |invitation| invitation.allowed_email.email }
    column(:name) { |invitation| invitation.allowed_email.name }
    column(:role) { |invitation| invitation.allowed_email.role }
    column :status
    column(:position) { |invitation| invitation.allowed_email.position }
    column(:manager) { |invitation| invitation.manager.email }
    column(:facilities) do |invitation|
      invitation.allowed_email.facilities.pluck(:name).sort.join(', ')
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :status
      row :position
      row :manager
      row(:facilities) do |invitation|
        invitation.allowed_email.facilities.pluck(:name).sort.join(', ')
      end
      row :token
      row :created_at
    end
  end
end
