class Player; end

class Stone
  attr_reader :sourcePlayer
  def initialize player
    @sourcePlayer = player
  end
end

class Board
  attr_accessor :matrix
  def initialize(args)
    upper_row = [nil, nil, nil]
    mid_row = [nil, nil, nil]
    lower_row = [nil, nil, nil]
    @matrix = [upper_row, mid_row, lower_row]
  end

  def valid_move?
  end

  def put_stone
  end

  def display_board
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