module Api
  class BusinessesController < ApiController
    skip_before_action :authenticate

    # GET /api/business
    def show
      if current_business.present?
        render json: BusinessSerializer.new(current_business)
      else
        render json: {
          error: "The business with the subdomain #{request.subdomain} doesn't exist."
        }, status: 404
      end
    end
  end
end
