class Property
  attr_accessor :name, :price, :color, :owner

  def initialize(name, price, color)
    @name = name
    @price = price
    @color = color
    @owner = nil      #No one owns it at the start
  end

  #check if the property is already owned
  def owned?
    return @owner != nil
  end
end