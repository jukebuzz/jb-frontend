module Decorator
  def initialize(component)
    @component = component
  end

  def method_missing(meth, *args)
    if @component.respond_to?(meth)
      @component.send(meth, *args)
    else
      super
    end
  end

  def respond_to?(meth)
    @component.respond_to?(meth)
  end
end
