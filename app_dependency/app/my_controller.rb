# Controller
class MyController
  def control
    result = 'it is nice to see you'

    response = { data: result }.to_json

    [200, response]
  end
end
