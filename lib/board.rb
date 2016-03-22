class Board
  attr_accessor :board

  def initialize
    @board = []
    row_counter = 1
    column_counter = 1

    6.times do
      row = []
      7.times do
        if column_counter == 8
          column_counter = 1
        end
        row << "Row #{row_counter} Column #{column_counter}"
        column_counter += 1
      end
      board << row
      row_counter += 1
    end
    board
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

  def print_board
    board.each_with_index do |row, row_index|
      row.each_with_index do |spot, col_index|
        spot_included = spot.include? "Col"

        if spot_included && col_index == 0
          print "| _ "
        elsif spot_included && col_index == 6
          print " _ |\n"
        elsif !spot_included && col_index == 0
          print "| #{spot} "
        elsif !spot_included && col_index == 6
          print " #{spot} |\n"
        elsif spot_included
          print " _ "
        else
          print " #{spot} "
        end
      end
    end
    puts "  1  2  3  4  5  6  7"
  end

  def board_full?
    board.flatten.none? { |spot| spot.include? "Col" }
    # full = true
    # board.each do |row|
      # row.each do |spot|
        # if spot.include?("Col")
          # full = false
        # end
      # end
    # end
    # full
  end

  def column_full?(index_values, choice, board, player)
    if index_values == []
      puts "That column is full. Please pick another column."
      column_choice = player.pick_column
      player.valid_choice?(column_choice, board, player)
    else
      board.board[index_values.last][choice - 1] = player.game_chip
    end
  end
end
