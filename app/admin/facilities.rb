ActiveAdmin.register Facility do
  menu priority: 4

  permit_params :name, :business_id

  config.sort_order = 'name_asc'

  controller do
    def create
      params[:facility][:business_id] = current_business.id
      super
    end
  end

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
    end
    f.actions
  end
end
