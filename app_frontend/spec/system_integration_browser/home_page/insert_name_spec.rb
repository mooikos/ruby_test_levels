describe 'insert name from home page' do
  let(:page) { Driver.new.session_get }

  it 'returns a success' do
    page.get('http://localhost:8080')

    # this test is missing a lot of wait

    label_headline = page.find_element(:css, '#result_label')
    expect(label_headline.text).to eql('tell me your name')

    input_field = page.find_element(:css, '#send_name')
    input_field.send_keys('the name')

    button_send = page.find_element(:css, 'button')
    expect(button_send.text).to eql('send')

    button_send.click

    label_result = page.find_element(:css, '#result_value')
    expect(label_result.text).to eql(
      'hello the name it is nice to see you'
    )
  end
end
