class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
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

  def valid_move?(location)
    if @matrix[location.y] == nil || @matrix[location.y][location.x] == nil
      false
    else
      if @matrix[location.y][location.x] == EMPTY
        true
      else
        false
      end
    end
  end

  def put_stone_at(stone, location)
    @matrix[location.y][location.x] = stone.sourcePlayer.mark
  end

  def display_board
    @matrix.each do |row|
      puts "#{row[0]} #{row[1]} #{row[2]}"
    end
  end

  def full?
    @matrix.each do |row|
      row.each do |e|
        return false if e == EMPTY
      end
    end
    return true
  end

  def win?
    if win_on_row? || win_on_column? || win_on_diagonal?
      true
    else
      false
    end
  end

  def win_on_row?
    returnVal = false
    @matrix.each do |row|
      # TODO: Refactor to more general algorithm
      if row[0] == row[1] && row[1] == row[2] && row[0] != EMPTY
        returnVal = true
        break
      end
    end
    returnVal
  end

  def win_on_column?
    returnVal = false
    # TODO: Refactor to more general algorithm
    if @matrix[0][0] == @matrix[1][0] && @matrix[1][0] == @matrix[2][0] && @matrix[0][0] != EMPTY
      returnVal = true
    elsif @matrix[0][1] == @matrix[1][1] && @matrix[1][1] == @matrix[2][1] && @matrix[0][1] != EMPTY
      returnVal = true
    elsif @matrix[0][2] == @matrix[1][2] && @matrix[1][2] == @matrix[2][2] && @matrix[0][2] != EMPTY
      returnVal = true
    end
    returnVal
  end

  def win_on_diagonal?
    returnVal = false
    # TODO: Refactor to more general algorithm
    if @matrix[0][0] == @matrix[1][1] && @matrix[1][1] == @matrix[2][2] && @matrix[0][0] != EMPTY
      # upperleft to lowerright
      returnVal = true
    elsif @matrix[0][2] == @matrix[1][1] && @matrix[1][1] == @matrix[2][0] && @matrix[0][2] != EMPTY
      # lowerleft to upperright
      returnVal = true
    end
    returnVal
  end
end

class Location
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end

class Game
  attr_reader :playerX, :playerY, :playerInTurn, :board

  def initialize
    display_welcome
    game_setup
  end

  def game_setup
    @board = Board.new
    @playerX = create_player
    @playerY = create_player
  end

  def create_player
    # prompt the user for player's name
    puts "What's the name of this player?"
    name = gets.chomp
    # prompt the user for player's mark
    puts "What's the mark of this player?"
    mark = gets.chomp
    # create the player and return
    Player.new(name, mark)
  end

  def continue?
    # stop when the board is no longer empty
    if @board.full?
      false
    elsif @board.win?
      false
    else
      true
    end
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
    while true
      @board.display_board
      parse_command
      break if not continue?
    end
    @board.display_board
    display_winner
    end_game
  end

  def parse_command
    case prompt_for_instruction
    when "move"
      location = prompt_for_location
      switch_player if make_move(location)
    when "exit"
      end_game
    else
      puts "Invalid command!"
    end
  end

  def prompt_for_instruction
    puts "Please enter a command (move or exit):"
    gets.chomp
  end

  def prompt_for_location
    puts "Please enter the x coordinate:"
    # convert the string to int then to 0-based
    x = gets.chomp.to_i - 1
    puts "Please enter the y coordinate:"
    y = gets.chomp.to_i - 1
    Location.new(x, y)
  end

  def end_game
    puts "GOODBYE!!!!"
    exit
  end

  def display_winner
    # the last player in turn is the winner
    winner = playerInTurn == playerX ? playerY : playerX
    puts "The winner is: #{winner.name}! Congratulations!"
  end

  def display_welcome
    puts "WELCOME!!!!"
  end

  def display_invalid_move
    puts "INVALID MOVE"
  end

  def make_move(location)
    if @board.valid_move?(location)
      stone = Stone.new(playerInTurn)
      @board.put_stone_at(stone, location)
      true
    else
      display_invalid_move
      false
    end
  end
end