# frozen_string_literal: true

require_relative 'position'
require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'
require_relative '../adapters/drawer'
require_relative '../adapters/messenger'

class Board
  attr_accessor :positions

  def initialize(drawer = Drawer.new)
    @positions = Array.new(8) { |row| Array.new(8) { |col| Position.new(row, col) } }
    @drawer = drawer
    set_initial_state
  end

  def display
    @drawer.display(@positions)
  end

  def execute_move(player, move)
    orig = move[0]
    dest = move[1]

    orig_position = @positions[orig[0]][orig[1]]
    dest_position = @positions[dest[0]][dest[1]]

    return false unless validate_move(player, orig_position, dest_position)

    move_piece(orig_position, dest_position)
  end

  def position_state(x, y)
    return nil if @positions[x][y].piece.nil?

    @positions[x][y].piece.color
  end

  private

  # TODO: maybe we will have an exclusive class for validation.
  # this will get bigger when insert check/checkmate
  def validate_move(player, orig, dest)
    moved_piece = orig.piece

    if moved_piece.nil?
      Messenger.notify_empty_position
      return false
    end

    if moved_piece.color != player.color
      Messenger.notify_opponent_piece
      return false
    end

    possible_moves = moved_piece.find_moves(self)

    unless possible_moves.include?(dest.as_array)
      Messenger.notify_not_possible_move(possible_moves)
      return false
    end

    true
  end

  def move_piece(orig, dest)
    piece = orig.piece

    @positions[dest.row][dest.col].piece = piece
    @positions[orig.row][orig.col].remove_piece

    piece.moved = true if piece.instance_of?(Pawn) || piece.instance_of?(Rook)
  end

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

    white_pawns_row.each_with_index { |_, col| white_pawns_row[col].piece = Pawn.new('white') }
    black_pawns_row.each_with_index { |_, col| black_pawns_row[col].piece = Pawn.new('black') }
  end

  def set_initial_rooks
    @positions[0][0].piece = Rook.new('white')
    @positions[0][7].piece = Rook.new('white')
    @positions[7][0].piece = Rook.new('black')
    @positions[7][7].piece = Rook.new('black')
  end

  def set_initial_knights
    @positions[0][1].piece = Knight.new('white')
    @positions[0][6].piece = Knight.new('white')
    @positions[7][1].piece = Knight.new('black')
    @positions[7][6].piece = Knight.new('black')
  end

  def set_initial_bishops
    @positions[0][2].piece = Bishop.new('white')
    @positions[0][5].piece = Bishop.new('white')
    @positions[7][2].piece = Bishop.new('black')
    @positions[7][5].piece = Bishop.new('black')
  end

  def set_initial_queens
    @positions[0][3].piece = Queen.new('white')
    @positions[7][3].piece = Queen.new('black')
  end

  def set_initial_kings
    @positions[0][4].piece = King.new('white')
    @positions[7][4].piece = King.new('black')
  end
end
