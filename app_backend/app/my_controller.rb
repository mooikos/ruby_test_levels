# Controller
class MyController
  include Errors::Validations

  def control(params:)
    params_permitted = {}
    params_permitted[:name] = validate_name(params[:name])

    result = MyModel.new.model(params: params_permitted)

    response = { data: result }.to_json

    [200, response]
  rescue MissingError, StringTooShortError => exception
    response = { error: exception.message }.to_json

    [400, response]
  end

  private_methods

  def validate_name(name)
    raise MissingError.new(parameter_name: :name) unless name

    if name.length < 5
      raise StringTooShortError.new(
        parameter_name: :name,
        expected_length: 5,
        actual_length: name.length
      )
    end

    name
  end
end
