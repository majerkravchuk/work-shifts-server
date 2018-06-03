ActiveAdmin.register User do
  permit_params :email, :role

  config.sort_order = 'id_asc'

  index do
    selectable_column
    id_column
    column :email
    column(:role) { |user| user.role.capitalize }
    column :created_at
    actions
  end

  filter :email
  filter :role
  filter :created_at

  show do
    attributes_table do
      row :email
      row(:role) { |user| user.role.capitalize }
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input(:role, {
        as: :select,
        collection: User.roles.reject { |r| r == 'admin' }.map { |k, v| [k.capitalize, k.to_sym] },
        include_blank: false
      })
    end
    f.actions
  end

end
