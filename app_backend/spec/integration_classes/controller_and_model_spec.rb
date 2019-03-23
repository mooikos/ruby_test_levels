describe 'integration of MyControl and MyModel' do
  let(:instance) { described_class }

  let(:mock_my_port) { instance_double(MyPort) }

  context 'MyControl#control' do
    context 'when "MyPort" returns "nil"' do
      let(:params) { { name: 'name_value' } }
      let(:my_port_result) { nil }

      before do
        expect(MyPort).to receive(:new).and_return(mock_my_port)
        expect(mock_my_port).to receive(:call_dependency)
          .and_return(my_port_result)
      end

      let(:expected_result) do
        [200, { data: 'hello ' + params[:name] }.to_json]
      end

      it 'returns a success' do
        expect(
          MyController.new.control(params: params)
        ).to eql(expected_result)
      end
    end
  end
end
