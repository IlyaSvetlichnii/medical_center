module V1
  class SuccessSerializer

    def self.serialize(success_message)
      return if success_message.nil?

      message_array = success_message.flat_map do |key, value|
        if value.kind_of?(Array)
          value.map {|msg| [id: key, title: msg]}
        else
          [id: key, title: value]
        end
      end

      { success_message: message_array }
    end

  end
end
