require_relative 'lib/game'
require 'json'

puts "Welcome to Woven Monopoly!"
puts " Choose a dice roll file : "
puts "1. rolls_1.json"
puts "2. rolls_2.json"
print "Enter 1 or 2 : "

choice = gets.chomp

roll_file = 
  case choice
  when "1"
    "data/rolls_1.json"
  when "2"
    "data/rolls_2.json"
  else
    puts "Invalid choice, selected 1.rolls_1.json"
    "data/rolls_1.json"
  end

rolls = JSON.parse(File.read(roll_file))

game = Game.new("data/board.json", rolls)
game.play