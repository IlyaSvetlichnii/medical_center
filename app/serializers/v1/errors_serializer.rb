module V1
  class ErrorsSerializer
    def self.serialize(result, request_details)
      return if result.errors.nil?

      result.errors.each do |error|
        error[:status] = Rack::Utils::SYMBOL_TO_STATUS_CODE[error[:status].to_sym]
        error[:meta] = error[:meta].merge(request_details[:request_details])
      end

      { errors: result.errors }
    end

    def self.json(id, title)
      { errors: [{ id: id, title: title}] }
    end
  end
end
