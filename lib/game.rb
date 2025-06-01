require_relative 'player'
require_relative 'property'
require_relative 'board'

class Game
  # 4 players in the game
  PLAYER_NAMES = ["Peter", "Billy", "Charlotte", "Sweedal"]

  def initialize(board_file, rolls)
    @board = Board.new(board_file)

    @players[]
    for name in PLAYER_NAMES
      @players.push(Player.new(name))      
    end

    @rolls = rolls

    @turn_index = 0

    @game_over = false
  end

  def play
    
    for roll in @rolls
      if @game_over
        break        
      end

      player_index = @turn_index % @players.length
      current_player = @players[player_index]

      take_turn(current_player, roll)

      turn_index += 1
    end

    show_results
  end

  def take_turn(player, roll)
    if player.bankrupt?
      return
    end

    old_position = player.position
    new_position = old_position + rolls

    if new_position >= @board.spaces.length
      new_position = new_position - @board.spaces.length
      player.money += 1
    end

    player.psoition = new_position

    if current_space.is_a?(Property)
      if current_space.owner == nil
        buy_property(player, current_space)
      elsif current_space.owner != player
        pay_rent(player, current_space)
      end
    end

    if player.money < 0
      @game_over = true
    end

    def buy_property(player, property)
      player.money = player.money - property.price
      player.properties.push(property)
      property.owner = player
    end

    def pay_rent(player, property)
      rent = property.price

      if full_color_owned(property.owner, property.color)
        rent = rent * 2
      end

      player.money = player.money - rent
      property.owner.money = property.owner.money + rent

      if player.money < 0
        player.bankrupt = true
      end
    end

    def full_color_owned(owner, color)
      properties_of_color[]
      for space in @board.spaces
        if space.is_a?(Property) && space.color == color
          properties_of_color.push(space)
        end        
      end

      for prop in propeterties_of_color
        if prop.owner != owner
          return fasle
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

      winner = @player[0]
      for p in @players
        if p.money > winner.money
          winner = p
        end
      end

      puts "\n ====== Winer is : #{winner.name}"
    end

  end





end