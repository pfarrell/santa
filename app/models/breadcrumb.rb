class Breadcrumb
  attr_accessor :path, :display

  def initialize(opts={})
    @path = opts[:path]
    @display = opts[:display]
  end
end
