describe MyController do
  let(:instance) { described_class.new }

  let(:mock_my_model) { instance_double(MyModel) }

  context '#control' do
    subject { instance.control(params: params) }

    context 'when "params[:name]" is missing' do
      let(:params) { { something_else: nil } }

      let(:expected_result) do
        error_message = Errors::Validations::MissingError.new(
          parameter_name: :name
        ).message

        [400, { error: error_message }.to_json]
      end

      it 'returns a error' do
        expect(subject).to eql(expected_result)
        binding.pry
      end
    end

    context 'when "params[:name]" is shorter then 5' do
      let(:params) { { name: 'abcd' } }

      let(:expected_result) do
        error_message = Errors::Validations::StringTooShortError.new(
          parameter_name: :name,
          expected_length: 5,
          actual_length: params[:name].length
        ).message

        [400, { error: error_message }.to_json]
      end

      it 'returns a error' do
        expect(subject).to eql(expected_result)
        binding.pry
      end
    end

    context 'when "MyModel" returns a value' do
      let(:params) { { name: 'name_value' } }
      let(:my_model_result) { 'my_model_result_value' }

      before do
        expect(MyModel).to receive(:new).and_return(mock_my_model)

        expect(mock_my_model).to receive(:model)
          .with(params: { name: params[:name] })
          .and_return(my_model_result)
      end

      let(:expected_result) do
        [200, { data: my_model_result }.to_json]
      end

      it 'returns a success' do
        expect(subject).to eql(expected_result)
        binding.pry
      end
    end
  end
end
