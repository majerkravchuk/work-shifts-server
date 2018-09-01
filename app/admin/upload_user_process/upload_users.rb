ActiveAdmin.register_page 'Upload users' do
  menu parent: 'Upload user process', priority: 1

  content do
    @result = UserUploader::Result.find_by id: params[:result_id], business: current_business
    @previous_results = UserUploader::Result.where(business: current_business).order(created_at: :desc)

    render partial: 'upload_users', locals: { result: @result, previous_results: @previous_results }
  end

  action_item :import_from_file, only: :index do
    # link_to 'Back to emails', admin_allowed_emails_path
  end

  page_action :create, method: :post do
    if params[:file].nil?
      redirect_to admin_upload_users_path, flash: { error: 'You did not select a file!' }
    else
      loader = UserUploader::FromXlsx.new current_business, current_user, params[:file]
      result = loader.parse!

      options = case result.status
                when 'uploaded'
                  { notice: 'The file was successfully uploaded!' }
                when 'uploaded_with_errors'
                  { flash: { warning: 'The file was uploaded, but some rows require correction.' } }
                else
                  { flash: { error: 'Sorry, something went wrong!' } }
                end

      redirect_to admin_upload_users_path(result_id: result.id), options
    end
  end

  page_action :download_example, method: :get do
    send_file 'public/users_example.xlsx', type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  end
end
