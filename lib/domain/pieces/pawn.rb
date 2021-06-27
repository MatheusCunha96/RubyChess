# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  attr_accessor :image, :moved
  attr_reader :possible_moves

  def initialize(color)
    # TODO: en passant
    @possible_moves = set_possible_moves(color)
    @moved = false

    super(color, color == 'white' ? '♟' : '♙')
  end

  def find_moves(board)
    moves = []

    @possible_moves.each_key do |move|
      column = current_col + @possible_moves[move][0]
      row = current_row + @possible_moves[move][1]

      next if column > 7 || row > 7

      position_state = board.position_state(row, column)

      case move
      when :one_step
        moves << [row, column] if position_state.nil?
      when :capture_left, :capture_right
        moves << [row, column] if position_state != @color && position_state !=nil
      when :double_step
        front_position_state = board.position_state(current_row + 1, current_col)

        moves << [row, column] if position_state.nil? && front_position_state.nil? && !@moved
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
