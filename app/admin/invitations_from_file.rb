ActiveAdmin.register_page 'Invitations from file' do
  menu false

  content do
    @result = InvitationLoading::Result.find_by(id: params[:result_id])
    render partial: 'invitations_from_file', locals: { result: @result }
  end

  page_action :create, method: :post do
    loader = InvitationLoaders::FromXlsx.new(
      params[:file], current_user, current_business
    )
    result = loader.parse!
    redirect_to admin_invitations_from_file_path(result_id: result.id)
  end

  page_action :download_example, method: :get do
    send_file 'public/invitations_example.xlsx',
              type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  end
end
