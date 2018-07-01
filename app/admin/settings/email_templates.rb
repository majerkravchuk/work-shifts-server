ActiveAdmin.register EmailTemplate do
  menu parent: 'Settings', priority: 1

  actions :index, :edit, :update

  permit_params :name, :body

  config.sort_order = 'name_asc'

  controller do
    def index
      EmailTemplate.sync_templates
      super
    end
  end

  index do
    column :name
    column :status
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :body
    end
    f.actions
  end
end
