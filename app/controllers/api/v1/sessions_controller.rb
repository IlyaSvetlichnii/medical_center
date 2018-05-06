module Api
  class V1::SessionsController < V1::BaseController
    skip_before_action :authenticate!, only: [:create]

    def create
      result = Sessions::Create.call(login_params)
      render resource_render_params(result, serializer: ::V1::SessionSerializer)
    end

    def show
      render json: @session, serializer: ::V1::SessionSerializer
    end

    private

    def login_params
      params.permit(:email, :password)
    end
  end
end
