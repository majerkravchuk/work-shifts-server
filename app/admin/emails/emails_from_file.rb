ActiveAdmin.register_page 'Emails from file' do
  menu parent: 'Emails', label: 'Import from file'

  content do
    @result = EmailLoader::Result.find_by(id: params[:result_id])
    @previous_results = EmailLoader::Result.order(created_at: :desc)
    render partial: 'emails_from_file', locals: { result: @result, previous_results: @previous_results }
  end

  action_item :import_from_file, only: :index do
    link_to 'Back to emails', admin_allowed_emails_path
  end

  page_action :create, method: :post do
    if params[:file].nil?
      redirect_to admin_emails_from_file_path, flash: { error: 'You did not select a file!' }
    else
      loader = EmailLoader::FromXlsx.new(
        current_business, current_user, params[:file]
      )
      result = loader.parse!

      if result.uploaded?
        redirect_to admin_emails_from_file_path(result_id: result.id), notice: 'File successfully uploaded!'
      else
        redirect_to admin_emails_from_file_path(result_id: result.id), flash: { error: 'Sorry, something went wrong!' }
      end
    end

  end

  page_action :download_example, method: :get do
    send_file 'public/emails_example.xlsx',
              type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  end
end
