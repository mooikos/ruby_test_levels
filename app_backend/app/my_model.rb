# Model
class MyModel
  def model(params:)
    result = 'hello ' + params[:name]
    postfix = MyPort.new.call_dependency
    result += ' ' + postfix unless postfix.nil?
    result
  end
end
