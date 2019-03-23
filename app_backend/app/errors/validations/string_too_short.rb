module Errors
  module Validations
    # denotes a missing expected parameter
    class StringTooShortError < StandardError
      def initialize(options = {})
        message = 'the "' + options[:parameter_name].to_s + '" parameter' \
                  ' is too short,' \
                  ' expected length of "' +
                  options[:expected_length].to_s + '"' \
                  ' found "' +
                  options[:actual_length].to_s + '"'
        super(message)
      end
    end
  end
end
