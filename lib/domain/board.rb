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
    update_positions_state
    update_positions_being_attacked
    update_pieces_possible_moves
  end

  def display
    @drawer.display(@positions)
  end

  def position_states(x, y)
    @positions[x][y].states
  end

  def move_piece(orig, dest)
    piece = orig.piece

    @positions[dest.row][dest.col].piece = piece
    @positions[orig.row][orig.col].remove_piece

    piece.moved = true if piece.instance_of?(Pawn) || piece.instance_of?(Rook)

    true
  end

  def update_pieces_possible_moves
    @positions.each do |row|
      row.each do |position|
        current_piece = position.piece

        next if current_piece.nil?

        current_piece.possible_moves = current_piece.find_moves(self)
      end
    end
  end

  def update_positions_state
    @positions.each do |row|
      row.each do |position|
        piece = position.piece

        if piece.nil?
          position.states[:free] = true
          position.states[:occupied_by_white] = false
          position.states[:occupied_by_black] = false
        elsif piece.white?
          position.states[:free] = false
          position.states[:occupied_by_white] = true
          position.states[:occupied_by_black] = false
        else
          position.states[:free] = false
          position.states[:occupied_by_white] = false
          position.states[:occupied_by_black] = true
        end

        position.states[:attacked_by_white] = false
        position.states[:attacked_by_black] = false
      end
    end
  end

  def update_positions_being_attacked
    @positions.each do |row|
      row.each do |position|
        piece = position.piece

        next if piece.nil?

        piece.update_attacking_fields

        next if piece.attacking_fields.empty?

        piece.attacking_fields.each do |field|
          row = field[0]
          column = field[1]

          if piece.white?
            @positions[row][column].states[:attacked_by_white] = true
          else
            @positions[row][column].states[:attacked_by_black] = true
          end
        end
      end
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
