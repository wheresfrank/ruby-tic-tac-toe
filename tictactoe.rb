puts "Let's get ready for some intense one-on-one tic-tac-toe action!!!"
puts 'Player one! Enter your name:'
$player_one = gets.chomp
puts 'Ok, Player two! Your turn:'
$player_two = gets.chomp
puts "I hope #{$player_one} and #{$player_two} are ready because loser buys beer."

class ClearBoard
  def initialize
    @i = 1
    $board_positions = {}
    9.times do
      $board_positions[:"#{@i}"] = @i.to_s
      @i += 1
    end
  end
  puts $board_positions
end

ClearBoard.new

class MakeBoard
  def initialize
    $board = "
             #{$board_positions[:"1"]} | #{$board_positions[:"2"]} | #{$board_positions[:"3"]}
             --+---+--
             #{$board_positions[:"4"]} | #{$board_positions[:"5"]} | #{$board_positions[:"6"]}
             --+---+--
             #{$board_positions[:"7"]} | #{$board_positions[:"8"]} | #{$board_positions[:"9"]}
             "
    puts $board
  end
end

MakeBoard.new

class Play
  def initialize; end

  @@turn = 1
  $win = false
  @@available_spots = [*'1'..'9']

  def Turns
    @@active_player = @@turn.odd? ? $player_one.to_s : $player_two.to_s
    @@marker = @@active_player == $player_one.to_s ? 'X' : 'O'
    puts "#{@@active_player} select a number on the board to play:"
    @play_position = gets.chomp
    if @@available_spots.include? @play_position
      $board_positions[:"#{@play_position}"] = @@marker
      @@turn += 1
      @@available_spots.delete(@play_position.to_s)
      MakeBoard.new
    else
      puts "#{@@active_player}, you picked #{@play_position}? Why, weirdo."
    end
  end

  def CheckWin
    if $board_positions.values_at(:"1", :"2", :"3") == [@@marker, @@marker, @@marker] ||
       $board_positions.values_at(:"4", :"5", :"6") == [@@marker, @@marker, @@marker] ||
       $board_positions.values_at(:"7", :"8", :"9") == [@@marker, @@marker, @@marker] ||
       $board_positions.values_at(:"1", :"4", :"7") == [@@marker, @@marker, @@marker] ||
       $board_positions.values_at(:"2", :"5", :"8") == [@@marker, @@marker, @@marker] ||
       $board_positions.values_at(:"3", :"6", :"9") == [@@marker, @@marker, @@marker] ||
       $board_positions.values_at(:"1", :"5", :"9") == [@@marker, @@marker, @@marker] ||
       $board_positions.values_at(:"3", :"5", :"7") == [@@marker, @@marker, @@marker]
      puts "#{@@active_player} you won! Way to tic tac that toe!"
      $win = true
    elsif @@available_spots.length == 0
      puts 'Game has ended in a tie'
      $win = true
    end
  end
end

active_game = Play.new

until $win
  active_game.Turns
  active_game.CheckWin
end