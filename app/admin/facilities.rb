ActiveAdmin.register Facility do
  permit_params :name

  config.sort_order = 'id_asc'

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

end
