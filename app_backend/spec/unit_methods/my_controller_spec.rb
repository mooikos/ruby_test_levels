describe MyController do
  let(:instance) { described_class.new }

  let(:mock_my_model) { instance_double(MyModel) }

  context '#control' do
    let(:params) { { name: 'name_value' } }

    subject { instance.control(params: params) }

    context 'when "validate_name" raise a "MissingError"' do
      let(:validate_name_error) do
        Errors::Validations::MissingError.new
      end
      let(:validate_name_message) { 'validate_name_message_value' }

      before do
        expect(instance).to receive(:validate_name)
          .with(params[:name])
          .and_raise(validate_name_error)
        expect(validate_name_error).to receive(:message)
          .and_return(validate_name_message)
      end

      let(:expected_result) do
        [400, { error: validate_name_message }.to_json]
      end

      it 'returns an error' do
        expect(subject).to eql(expected_result)
      end
    end

    context 'when "validate_name" raise a "StringTooShortError"' do
      xit 'returns an error'
    end

    context 'when "validate_name" returns "nil"' do
      xit 'returns an error'
    end

    context 'when "validate_name" raise an unexpected error' do
      xit 'returns an error'
    end

    context 'when "validate_name" returns a value' do
      let(:validate_name_result) { 'validate_name_result_value' }

      before do
        expect(instance).to receive(:validate_name)
          .with(params[:name])
          .and_return(validate_name_result)

        expect(MyModel).to receive(:new).and_return(mock_my_model)
      end

      context 'when "MyModel" returns a value' do
        let(:my_model_result) { 'my_model_result_value' }

        before do
          expect(mock_my_model).to receive(:model)
            .with(params: { name: validate_name_result })
            .and_return(my_model_result)
        end

        let(:expected_result) do
          [200, { data: my_model_result }.to_json]
        end

        it 'returns a success' do
          expect(subject).to eql(expected_result)
        end
      end
    end
  end
end
