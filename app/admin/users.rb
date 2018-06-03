ActiveAdmin.register User do
  menu priority: 1

  includes :position

  permit_params :email, :role, :position_id

  config.sort_order = 'id_asc'

  index do
    selectable_column
    id_column
    column :email
    column(:role) { |user| user.role.capitalize }
    column(:position) { |user| user.position.name.capitalize }
    column :created_at
    actions
  end

  filter :email
  filter :role
  filter :position
  filter :created_at

  show do
    attributes_table do
      row :email
      row(:role) { |user| user.role.capitalize }
      row(:position) { |user| user.position.name.capitalize }
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input(:role, {
        as: :select,
        collection: User.roles.reject { |r| r == 'admin' }.map { |k, _v| [k.capitalize, k.to_sym] },
        include_blank: false
      })
      f.input(:position, {
        as: :select,
        collection: current_user.business.positions.map { |p| [p.name.capitalize, p.id] },
        include_blank: false
      })
      f.input :business_id, input_html: { value: current_user.business.id }, as: :hidden
    end
    f.actions
  end
end
