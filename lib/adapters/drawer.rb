# frozen_string_literal: true

require 'colorize'

class Drawer
  def display(board)
    display_board(board)
    display_x_axis
  end

  private

  def display_board(board)
    board.reverse.each_with_index do |row, row_number|
      display_number = 1 + (row_number - 7) * -1
      display_row(row, display_number)
    end
  end

  def display_row(row, display_number)
    row.each_with_index do |position, index|
      print "  #{display_number} " if index.zero?

      colors_options = color_for_position(position)
      piece_image = image_map[position.piece.class.name.downcase.to_sym]

      if position.piece.nil?
        print '   '.colorize(colors_options)
      else
        print piece_image.colorize(colors_options)
      end

    end
    print("\n")
  end

  def display_x_axis
    p '    a  b  c  d  e  f  g  h'
  end

  def color_for_position(position)
    colors = { background: :light_black, color: :nil }

    colors[:background] = :black if (position.row + position.col).even?

    colors[:color] = position.piece.white? ? :light_yellow : :light_blue if position.piece

    colors
  end

  def image_map
    {
      pawn:   ' ♟ ',
      rook:   ' ♜ ',
      knight: ' ♞ ',
      bishop: ' ♝ ',
      queen:  ' ♛ ',
      king:   ' ♚ '
    }
  end
end
