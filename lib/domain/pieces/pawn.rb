# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  attr_accessor :image
  attr_reader :possible_moves

  def initialize(color)
    # TODO: en passant
    @possible_moves = set_possible_moves(color)

    super(color, color == 'white' ? '♟' : '♙')
  end

  def find_moves(board)
    moves = []

    @possible_moves.each_key do |move|
      column = current_col + @possible_moves[move][0]
      row = current_row + @possible_moves[move][1]

      case move
      when :one_step
        moves << [row, column] if board.position_state(row,column).nil?
      when :capture_left, :capture_right
        position_state = board.position_state(row, column)

        moves << [row, column] if position_state != @color && position_state !=nil
      end
    end

    moves
  end

  private

  def set_possible_moves(color)
    if color == 'white'
      {
        one_step:      [0,1],
        double_step:   [0,2],
        capture_left:  [-1,1],
        capture_right: [1,1]
      }
    else
      {
        one_step:      [0,-1],
        double_step:   [0,-2],
        capture_left:  [1,-1],
        capture_right: [-1,-1]
      }
    end
  end
end
