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

    def update
      params[:email_template][:body].gsub!('&lt;', '<')
      params[:email_template][:body].gsub!('&gt;', '>')
      resource.edited!
      super
    end
  end

  member_action :restore_template, method: :post do
    notice =
      resource.default? ? 'The template was successfully updated.' : 'The template was successfully restored.'
    resource.restore_template!
    redirect_to admin_email_templates_path, notice: notice
  end

  index do
    column :name
    column :status
    actions defaults: true do |template|
      label = template.default? ? 'Update' : 'Restore'
      link_to label, restore_template_admin_email_template_path(template), method: :post
    end
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name, input_html: { readonly: true, disabled: true }
      f.input :body, as: :trumbowyg, input_html: { data:
        {
          options: {
            btns: [
              ['bold', 'italic'],
              ['superscript', 'subscript'],
              ['justifyLeft', 'justifyCenter', 'justifyRight', 'justifyFull'],
              ['unorderedList', 'orderedList'],
              ['horizontalRule'], ['removeformat']
            ]
          }
        }
      }
    end
    f.actions
  end
end
