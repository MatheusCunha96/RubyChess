# frozen_string_literal: true

# Hexagonal -> framework

class Drawer
  def display(board)
    display_top_board
    display_board_rows(board)
    display_bottom_board
    display_x_axis
  end

  private

  def display_board_rows(board)
    board.reverse.each_with_index do |row, row_number|
      display_number = 1 + (row_number - 7) *  -1
      display_row(row, display_number)
      display_middle_board unless row_number == 7
    end
  end

  def display_row(row, display_number)
    row.each_with_index do |position, index|
      print index.zero? ? "  #{display_number} " : ' '
      print '│  '
      print position.piece.nil? ? '.' : position.piece.image
      print ' │' if index == 7
    end
    print("\n")
  end

  def display_top_board
    p '   ┌────┬────┬────┬────┬────┬────┬────┬────┐'
  end

  def display_bottom_board
    p '   └────┴────┴────┴────┴────┴────┴────┴────┘'
  end

  def display_middle_board
    p '   ├────┼────┼────┼────┼────┼────┼────┼────┤'
  end

  def display_x_axis
    p '     a    b    c    d    e    f    g    h   '
  end
end
