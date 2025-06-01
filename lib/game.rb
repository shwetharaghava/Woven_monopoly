require_relative 'player'
require_relative 'property'
require_relative 'board'

class Game
  # 4 players in the game
  PLAYER_NAMES = ["Peter", "Billy", "Charlotte", "Sweedal"]

  def initialize(board_file, rolls)
    @board = Board.new(board_file)      #set up the board using JSON file

    @players = []                       #create a player object for each name
    for name in PLAYER_NAMES
      @players.push(Player.new(name))      
    end

    #save the list of dice rolls for the game
    @rolls = rolls

    #keeps track of whose turn is is
    @turn_index = 0

    #to stop the game if someone goes bankrupt
    @game_over = false
  end

  
  def play
    #go through all the rolls one by one
    for roll in @rolls
      if @game_over
        break        
      end

      #pick the current player based on turn index
      player_index = @turn_index % @players.length
      current_player = @players[player_index]

      #player take their turn
      take_turn(current_player, roll)

      #move to next turn
      @turn_index += 1
    end
    #to show final game results
    show_results
  end

  def take_turn(player, roll)
    #skip this player if they are bankrupt
    if player.bankrupt?
      return
    end

    #move the player on the board
    old_position = player.position
    new_position = old_position + roll

    #if the player goes pat the end, wrap around and give $1
    if new_position >= @board.spaces.length
      new_position = new_position - @board.spaces.length
      player.money += 1
    end

    player.position = new_position

    #get the space the player landed on
    current_space = @board.get_space(new_position)

    #check what to do based on the type of space
    if current_space.is_a?(Property)
      if current_space.owner == nil
        buy_property(player, current_space)
      elsif current_space.owner != player
        pay_rent(player, current_space)
      end
    end

    #to end the game
    if player.money < 0
      @game_over = true
    end
  end

  def buy_property(player, property)
    player.money = player.money - property.price
    player.properties.push(property)
    property.owner = player
  end

  def pay_rent(player, property)
    rent = property.price

    #double rent, if all property is owned
    if full_color_owned(property.owner, property.color)
      rent = rent * 2
    end

    #pay rent to the owner
    player.money = player.money - rent
    property.owner.money = property.owner.money + rent

    if player.money < 0
      player.bankrupt = true
    end
  end

  def full_color_owned(owner, color)
    #find all properties of the same color
    properties_of_color = []
    for space in @board.spaces
      if space.is_a?(Property) && space.color == color
        properties_of_color.push(space)
      end        
    end

    #check if the owner owns all of them
    for prop in properties_of_color
      if prop.owner != owner
        return false
      end
    end
    return true
  end

  def show_results
    puts "\n ========== Game Over =========="

    for p in @players
      pos = @board.get_space(p.position)
      pos_name = pos.is_a?(Property) ? pos.name : pos
      bank = p.bankrupt ? "YES" : "NO"

      puts "#{p.name} - Money: $#{p.money}, Position: #{pos_name}, Bankrupt: #{bank}"
    end

    winner = @players[0]
    for p in @players
      if p.money > winner.money
        winner = p
      end
    end

    puts "\n ====== Winer is : #{winner.name} ======"
  end
end