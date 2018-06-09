ActiveAdmin.register Business do
  menu priority: 2

  permit_params :name, :subdomain

  config.sort_order = 'id_asc'

  index do
    column :name
    column :subdomain
    actions
  end

  filter :name

  show do
    attributes_table do
      row :name
      row :subdomain
      row :created_at
    end
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :subdomain
    end
    f.actions
  end
end
