module Errors
  module Validations
    # denotes a missing expected parameter
    class MissingError < StandardError
      def initialize(options = {})
        super('missing "' + options[:parameter_name].to_s + '" parameter')
      end
    end
  end
end
