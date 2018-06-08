ActiveAdmin.register User do
  menu priority: 1

  includes :position

  permit_params :email, :position_id, :password, :password_confirmation

  config.sort_order = 'id_asc'

  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end
      super
    end
  end

  index do
    column :email
    column(:position) { |user| user.position.name.capitalize }
    column :created_at
    actions
  end

  filter :email
  filter :position
  filter :created_at

  show do
    attributes_table do
      row :email
      row(:position) { |user| user.position.name.capitalize }
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
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
