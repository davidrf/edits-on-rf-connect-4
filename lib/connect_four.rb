require 'pry'
require_relative "player"
require_relative "board"

class Game
  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = []
  end

  def start_game
    puts "Welcome to a game of Connect Four!"
    get_player_name until players.count == 2
    board.print_board
    turn(player_1, board)
  end

  def get_player_name
    player_number = players.count + 1
    name = nil
    name_already_exists = true
    while name_already_exists
      print "Player #{player_number}, please enter your name: "
      name = gets.chomp
      name_already_exists = players.find { |player| player.name == name }
      puts "Both players can't have the same name." if name_already_exists
    end
    players << Player.new(name, player_number)
  end

  def player_1
    players.first
  end

  def player_2
    players.last
  end

  def turn(player, board)
    puts "It's #{player.name}'s turn"

    column_choice = player.pick_column

    # D-Rod's wishful implementation
    # valid_choice = board.valid_choice?(column_choice)
    # until valid_choice
      # column_choice = player.pick_column
      # valid_choice = board.valid_choice?(column_choice)
    # end
    # board.update_board(column_choice, player)

    player.valid_choice?(column_choice, board, player)

    board.print_board

    switch_turns(player, board)
  end

  def switch_turns(player, board)
    if player.winner?(player, board) == true
      display_winning_message(player)
    elsif board.board_full?
      puts "The board is full."
      play_again(player)
    elsif player == player_1
      turn(player_2, board)
    else
      turn(player_1, board)
    end
  end

  def display_winning_message(player)
    accept_answers = ["y", "n"]

    puts "Connect Four! #{player.name} wins the game!"

    play_again(player)
  end

  def play_again(player)
    accept_answers = ["y", "n"]

    print "Would you like to play again? (Y / N): "
    answer = gets.chomp

    if !accept_answers.include?(answer.downcase)
      puts "You have to answer Y or N."
      play_again(player)
    end

    if answer.downcase == "y"
      puts "Great!  Here we go again!"
      board = Board.new
      turn(player, board)
    else
      puts "Ok. Let's play again sometime."
    end
  end
end

game = Game.new
game.start_game

