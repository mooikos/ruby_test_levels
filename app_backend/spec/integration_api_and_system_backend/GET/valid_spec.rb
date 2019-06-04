describe 'GET /' do
  # some needed includes
  include Rack::Test::Methods
  let(:app) { AppBackend.new }

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
    context 'when the dependency is under heavy load' do
      before do
        stub_request(:get, 'http://localhost:3001/')
          .to_return(status: 503, body: '')
      end

      it 'returns a result' do
        get '/?name=enough'

        expect(last_response.status).to be 200

        parsed_body = JSON.parse(last_response.body)
        expect(parsed_body).to eql(
          'data' => 'hello enough'
        )
        binding.pry
      end

      context 'when the dependency answers' do
        let(:dependency_response) do
          { 'data' => 'it is nice to see you' }
        end

        before do
          stub_request(:get, 'http://localhost:3001/')
            .to_return(status: 200, body: dependency_response.to_json)
        end

        it 'returns a result' do
          get '/?name=enough'

          expect(last_response.status).to be 200

          parsed_body = JSON.parse(last_response.body)
          expect(parsed_body).to eql(
            'data' => 'hello enough' + ' ' + dependency_response['data']
          )
          binding.pry
        end
      end
    end
  end
end
