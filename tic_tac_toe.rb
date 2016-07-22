class Player; end

class Stone
  attr_reader :sourcePlayer
  def initialize player
    @sourcePlayer = player
  end
end

class Board
  attr_accessor :matrix

  def initialize(empty)
    upper_row = [empty, empty, empty]
    mid_row = [empty, empty, empty]
    lower_row = [empty, empty, empty]
    @matrix = [upper_row, mid_row, lower_row]
  end

  def valid_move?
  end

  def put_stone
  end

  def display_board
    @matrix.each do |row|
      puts "#{row[0]} #{row[1]} #{row[2]}"
    end
  end
end

class Game
  attr_reader :playerO, :playerX
  attr_accessor :playerInTurn

  def initialize(args)

  end

  def continue?
  end

  def switch_player
  end

  def start_game
  end

  def end_game
  end

  def display_winner
  end

  def display_welcome
  end

end