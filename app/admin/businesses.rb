ActiveAdmin.register Business do
  menu priority: 2

  permit_params :name, :subdomain, :time_zone

  config.sort_order = 'name_asc'

  index do
    column :name
    column :subdomain
    column :time_zone
    actions
  end

  filter :name

  show do
    attributes_table do
      row :name
      row :subdomain
      row :time_zone
      row :created_at
    end
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :subdomain
      f.input :time_zone, as: :time_zone
    end
    f.actions
  end
end
