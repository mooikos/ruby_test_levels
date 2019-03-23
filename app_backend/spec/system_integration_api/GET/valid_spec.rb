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
    end
  end

  context 'when "name" parameter is correct' do
    # this scenario requires services manipulation
    context 'when the dependency is under heavy load' do
      it 'returns a result' do
        get '/?name=enough'

        expect(last_response.status).to be 200

        parsed_body = JSON.parse(last_response.body)
        expect(parsed_body).to eql(
          'data' => 'hello enough'
        )
      end

      context 'when the dependency answers' do
        it 'returns a result' do
          get '/?name=enough'

          expect(last_response.status).to be 200

          parsed_body = JSON.parse(last_response.body)
          expect(parsed_body).to eql(
            'data' => 'hello enough' + ' ' + 'it is nice to see you'
          )
        end
      end
    end
  end
end
