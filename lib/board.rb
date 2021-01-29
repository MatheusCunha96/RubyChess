# frozen_string_literal: true

require_relative 'position'
require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'drawer'

class Board
  attr_accessor :positions

  def initialize(drawer = Drawer.new)
    @positions = Array.new(8) { Array.new(8, nil) }
    @drawer = drawer
    set_initial_state
  end

  def display
    @drawer.display(@positions)
  end

  private

  def set_initial_state
    set_initial_pawns
    set_initial_rooks
    set_initial_knights
    set_initial_bishops
    set_initial_queens
    set_initial_kings
  end

  def set_initial_pawns
    white_pawns_row = @positions[1]
    black_pawns_row = @positions[6]

    white_pawns_row.each_with_index { |_, col| white_pawns_row[col] = Pawn.new(Position.new(1, col), 'white') }
    black_pawns_row.each_with_index { |_, col| black_pawns_row[col] = Pawn.new(Position.new(6, col), 'black') }
  end

  def set_initial_rooks
    @positions[0][0] = Rook.new(Position.new(0, 0), 'white')
    @positions[0][7] = Rook.new(Position.new(0, 7), 'white')
    @positions[7][0] = Rook.new(Position.new(7, 0), 'black')
    @positions[7][7] = Rook.new(Position.new(7, 7), 'black')
  end

  def set_initial_knights
    @positions[0][1] = Knight.new(Position.new(0, 1), 'white')
    @positions[0][6] = Knight.new(Position.new(0, 6), 'white')
    @positions[7][1] = Knight.new(Position.new(7, 1), 'black')
    @positions[7][6] = Knight.new(Position.new(7, 6), 'black')
  end

  def set_initial_bishops
    @positions[0][2] = Bishop.new(Position.new(0, 2), 'white')
    @positions[0][5] = Bishop.new(Position.new(0, 5), 'white')
    @positions[7][2] = Bishop.new(Position.new(7, 2), 'black')
    @positions[7][5] = Bishop.new(Position.new(7, 5), 'black')
  end

  def set_initial_queens
    @positions[0][3] = Queen.new(Position.new(0, 3), 'white')
    @positions[7][3] = Queen.new(Position.new(7, 3), 'black')
  end

  def set_initial_kings
    @positions[0][4] = King.new(Position.new(0, 4), 'white')
    @positions[7][4] = King.new(Position.new(7, 4), 'black')
  end
end
