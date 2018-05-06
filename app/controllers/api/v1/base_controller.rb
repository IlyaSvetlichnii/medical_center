module Api
  module V1
    class BaseController < Api::BaseController
      protect_from_forgery with: :null_session

      before_action :authenticate!, except: [:generate_auth_token_test]

      before_action :api_version

      protected

      def resources_render_params result, each_serializer: nil, include: nil, variables: nil
        if result.success?
          payload = result.resources

          options = {
            status: result.status,
            json: payload,
          }

          if each_serializer
            options.merge! each_serializer: each_serializer
          else
            if serializer_class = detect_serializer_class(result)
              options.merge! each_serializer: serializer_class
            end
          end

          if variables
            options.merge! variables: variables
          end

          if result.include
            options.merge! include: result.include
          else
            if include
              options.merge! include: include
            end
          end

          render_params = if payload
                            if payload.respond_to? :total_pages
                              options.merge! meta: pagination_params(payload)
                            end

                            options
                          else
                            { status: result.status, body: nil }
                          end
          render_params
        else
          {
            status: result[:errors][0][:status].to_sym,
            json: ::V1::ErrorsSerializer.serialize(result, request_details)
          }
        end
      end

      def resource_render_params result, serializer: nil
        if result.success? && result.success_message.present?
          {
            status: result.status,
            json: ::V1::SuccessSerializer.serialize(result.success_message)
          }

        elsif result.success?
          options = { status: result.status }

          if serializer
            options.merge! serializer: serializer
          else
            if serializer_class = detect_serializer_class(result)
              options.merge! serializer: serializer_class
            end
          end

          result.resource.present? ? options.merge!(json: result.resource) : options.merge!(body: nil)
          options
        else
          {
            status: result[:errors][0][:status].to_sym,
            json: ::V1::ErrorsSerializer.serialize(result, request_details)
          }
        end
      end

      def request_details
        details = {
          request_details: {
            request_method: request.method,
            original_url: request.original_url,
          }
        }

        details
      end
    end
  end
end
