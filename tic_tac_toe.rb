class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def make_move(x, y)
    stone = Stone.new(self)
  end
end

class Stone
  attr_reader :sourcePlayer

  def initialize(player)
    @sourcePlayer = player
  end
end

class Board
  attr_accessor :matrix

  EMPTY = "="

  def initialize
    upper_row = [EMPTY, EMPTY, EMPTY]
    mid_row = [EMPTY, EMPTY, EMPTY]
    lower_row = [EMPTY, EMPTY, EMPTY]
    @matrix = [upper_row, mid_row, lower_row]
  end

  def valid_move?(x, y)
    unless @matrix[y][x] == "="
      false
    else
      true
    end
  end

  def put_stone_at(stone, x, y)
    @matrix[y][x] = stone.sourcePlayer.mark
  end

  def display_board
    @matrix.each do |row|
      puts "#{row[0]} #{row[1]} #{row[2]}"
    end
  end
end

class Game
  attr_reader :playerX, :playerY, :playerInTurn, :board

  def initialize
    @board = Board.new
    @playerX = Player.new("X", "X")
    @playerY = Player.new("Y", "O")
    start_game
  end

  def continue?
  end

  def switch_player
    if @playerInTurn == @playerX
      @playerInTurn = @playerY
    else
      @playerInTurn = @playerX
    end
  end

  def start_game
    @playerInTurn = @playerX
  end

  def end_game
  end

  def display_winner
  end

  def display_welcome
  end

  def display_invalid_move
    puts "INVALID MOVE"
  end

  def make_move(x, y)
    if @board.valid_move?(x, y)
      stone = Stone.new(playerInTurn)
      @board.put_stone_at(stone, x, y)
    else
      display_error
    end
  end

end