# port
class MyPort
  def call_dependency
    response_body = RestClient.get(endpoint).body
    response_parsed = JSON.parse(response_body)
    response_parsed['data']
  rescue Errno::ECONNREFUSED,
         RestClient::ExceptionWithResponse => _exception
    # for now do nothing about it
    nil
  end

  private_methods

  def endpoint
    'http://localhost:3001/'
  end
end
