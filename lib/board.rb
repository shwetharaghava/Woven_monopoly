require 'json'
require_relative 'property'

class Board
  attr_accessor :spaces

  def initialize(file_path)
    @spaces = []

    #load board JSON file
    file_data = File.read(file_path)
    board_data = JSON(file_data)

    #Go through each space and add to board
    for space in board_data
      if space["type"] == "property"
        property = Property.new(space["name"], space["price"], space["color"])
        @spaces.push(property)
      else
        @spaces.push(space["name"]) #to store "GO"
      end
    end
  end

  #to get the space at a certain position
  def get_space(index)
    return @spaces[index]
  end
end