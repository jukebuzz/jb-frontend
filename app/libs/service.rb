class Service
  def initialize(options)
    options.each do |k, v|
      instance_variable_set "@#{k}", v
    end
  end
end
