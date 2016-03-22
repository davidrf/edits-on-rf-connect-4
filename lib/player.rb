class Player
  attr_reader :name, :game_chip

  def initialize(name, player_1_or_2)
    @name = name
    @id = player_1_or_2
    @game_chip =  if player_1_or_2 == 1
                    game_chip = "X"
                  else
                    game_chip = "O"
                  end
  end

  def pick_column
    print "What column would you like to add your game piece too? (Choose 1-7): "
    column_choice = gets.chomp.to_i
  end

  def valid_choice?(choice, board, player)
    column_choices = 1..7

    if !column_choices.include?(choice)
      puts "You have to choose 1, 2, 3, 4, 5, 6, or 7 for the column number."
      column_choice = pick_column
      valid_choice?(column_choice, board, player)
    else
      largest_index(choice, board, player)
    end
  end

  def largest_index(choice, board, player)
    index_values = []

    board.board.each_with_index do |row, row_index|
      if row[choice - 1].include?("Col")
        index_values << row_index
      end
    end
    board.column_full?(index_values, choice, board, player)
  end

  def vertical_win(player, board, winning, game_chip_count, column_counter)
    while column_counter <= 6
      board.board.each do |row|
        if row[column_counter] == player.game_chip
          game_chip_count += 1
        else
          game_chip_count = 0
        end

        if game_chip_count >= 4
          winning = true
        end
      end
      game_chip_count = 0
      column_counter += 1
    end
    winning
  end

  def horizontal_win(player, board, winning, game_chip_count)
    board.board.each do |row|
      row.each do |spot|
        if spot == player.game_chip
          game_chip_count += 1
        else
          game_chip_count = 0
        end

        if game_chip_count >= 4
          winning = true
        end
      end
      game_chip_count = 0
    end
    winning
  end

  def winner?(player, board)
    winning = false
    game_chip_count = 0
    column_counter = 0

    vert_win = vertical_win(player, board, winning, game_chip_count, column_counter)

    hor_win = horizontal_win(player, board, winning, game_chip_count)

    if vert_win || hor_win
      winning = true
    end

    winning
  end
end
