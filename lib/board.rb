# frozen_string_literal: true

require 'byebug'
require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'

class Board
  attr_accessor :positions

  def initialize
    @positions = Array.new(8) { Array.new(8, nil) }
    set_initial_state
  end

  def display
    @positions.each do |rows|
      rows.each do |piece|
        print piece.nil? ? '.' : piece.image
        print "\t"
      end
      print "\n"
    end
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

    white_pawns_row.each_with_index { |_, position| white_pawns_row[position] = Pawn.new }
    black_pawns_row.each_with_index { |_, position| black_pawns_row[position] = Pawn.new }
  end

  def set_initial_rooks
    @positions[0][0] = Rook.new
    @positions[0][7] = Rook.new
    @positions[7][0] = Rook.new
    @positions[7][7] = Rook.new
  end

  def set_initial_knights
    @positions[0][1] = Knight.new
    @positions[0][6] = Knight.new
    @positions[7][1] = Knight.new
    @positions[7][6] = Knight.new
  end

  def set_initial_bishops
    @positions[0][2] = Bishop.new
    @positions[0][5] = Bishop.new
    @positions[7][2] = Bishop.new
    @positions[7][5] = Bishop.new
  end

  def set_initial_queens
    @positions[0][3] = Queen.new
    @positions[7][3] = Queen.new
  end

  def set_initial_kings
    @positions[0][4] = King.new
    @positions[7][4] = King.new
  end
end
