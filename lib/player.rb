class Player
  attr_accessor :name, :memory, :position, :properties, :bankrupt

  def initialize(name)
    @name = name
    @money = 16
    @position = 0
    @properties = []
    @bankrupt = false
  end

  #check if the player is bankrupt
  def bankrupt?
    return @bankrupt
  end
end