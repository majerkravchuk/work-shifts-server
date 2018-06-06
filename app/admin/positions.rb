ActiveAdmin.register Position do
  menu priority: 3

  permit_params :name, :business_id

  config.sort_order = 'id_asc'

  index do
    selectable_column
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

  form do |f|
    f.inputs do
      f.input :name
      f.input :access_to, as: :check_boxes, collection: [ ['Physician', 1], ['App', 1], ['Other user\'s position', 1] ]
      f.input :business_id, input_html: { value: current_user.business.id }, as: :hidden
    end
    f.actions
  end
end
