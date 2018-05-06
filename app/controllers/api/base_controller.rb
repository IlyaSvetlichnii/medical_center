module Api
  class BaseController < ApplicationController

    protected

    def authenticate!
      authenticate_token || render_unauthorized
    end

    def api_version
      @version ||= begin
                     version_range = 1..2

                     accept_header_value = request.headers['HTTP_ACCEPT']
                     match_data = /application\/vnd\.medicalCenter\.v(\d+)/.match(accept_header_value)
                     (match_data && match_data[1] && version_range.include?(match_data[1].to_i)) ? match_data[1].to_i : nil
                   end

      if @version.nil? && request.headers['Accept'].exclude?("application/vnd.medicalCenter.web")
        render status: :not_acceptable, json: {errors: [{title: "Wrong version"}]} and return
      end

      return @version
    end

    def pagination_params resource_relation
      if resource_relation.present?
        {
          next_page: resource_relation.next_page,
          prev_page: resource_relation.prev_page,
          total_pages: resource_relation.total_pages
        }
      end
    end

    # def current_user
    #   @session.user
    # end

    private

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @session = Session.find(options['session'])
        session_valid = @session.token == token

        session_valid && @session.user.present?
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="medicalCenter"'
      render json: {errors: [{access: 'Bad credentials'}]}, status: :forbidden
    end
  end
end
