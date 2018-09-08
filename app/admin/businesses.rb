ActiveAdmin.register Business do
  menu priority: 2

  permit_params :name, :time_zone

  config.sort_order = 'name_asc'

  collection_action :switch, method: :get do
    business = Business.find_by(id: params[:business])
    if business.present?
      current_user.update(business: business)
      redirect_to request.referrer, notice: "The business successfully switched to #{business.name}"
    else
      redirect_to request.referrer, flash: {
        error: 'You do not have access to this business!'
      }
    end
  end

  index do
    column :name
    column :time_zone
    actions
  end

  filter :name

  show do
    attributes_table do
      row :name
      row :time_zone
      row :created_at
    end
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :time_zone, as: :time_zone
    end
    f.actions
  end
end
