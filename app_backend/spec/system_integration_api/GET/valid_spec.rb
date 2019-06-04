describe 'GET /' do
  # some needed includes
  include Rack::Test::Methods
  let(:app) { AppBackend.new }

  before do
    WebMock.allow_net_connect!
  end

  # is this the correct place ?
  context 'when no parameters' do
    it 'returns an error' do
      get '/'

      parsed_body = JSON.parse(last_response.body)

      expect(parsed_body).to eql(
        'error' => 'missing "name" parameter'
      )
      binding.pry
    end
  end

  # is this the correct place ?
  context 'when "name" parameter is too short' do
    it 'returns an error' do
      get '/?name=kurz'

      parsed_body = JSON.parse(last_response.body)

      expect(parsed_body).to eql(
        'error' => 'the "name" parameter is too short' \
                   ', expected length of "5" found "4"'
      )
      binding.pry
    end
  end

  context 'when "name" parameter is correct' do
    # NOTE: this scenario requires app_dependency NOT active
    context 'when the dependency is under heavy load' do
      it 'returns a result' do
        get '/?name=enough'

        expect(last_response.status).to be 200

        parsed_body = JSON.parse(last_response.body)
        expect(parsed_body).to eql(
          'data' => 'hello enough'
        )
        binding.pry
      end
    end

    # NOTE: this scenario requires app_dependency active
    context 'when the dependency answers' do
      it 'returns a result' do
        get '/?name=enough'

        expect(last_response.status).to be 200

        parsed_body = JSON.parse(last_response.body)
        expect(parsed_body).to eql(
          'data' => 'hello enough' + ' ' + 'it is nice to see you'
        )
        binding.pry
      end
    end
  end
end
