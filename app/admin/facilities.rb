ActiveAdmin.register Facility do
  menu priority: 2

  permit_params :name, :business_id

  config.sort_order = 'id_asc'

  index do
    column :name
    actions
  end

  filter :name

  show do
    attributes_table do
      row :name
      row :created_at
    end
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :business_id, input_html: { value: current_user.business.id }, as: :hidden
    end
    f.actions
  end
end
