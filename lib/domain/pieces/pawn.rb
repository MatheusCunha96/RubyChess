# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  attr_accessor :image, :moved
  attr_reader :move_set

  def initialize(color)
    # TODO: en passant
    @move_set = set_move_set(color)
    @moved = false

    super(color, color == 'white' ? '♟' : '♙')
  end

  def find_moves(board)
    moves = []

    @move_set.each_key do |move|
      column = current_col + @move_set[move][0]
      row = current_row + @move_set[move][1]

      next if Piece.out_of_bounds?(row, column)

      position_state = board.position_state(row, column)

      case move
      when :one_step
        moves << [row, column] if position_state.nil?
      when :capture_left, :capture_right
        moves << [row, column] if position_state != @color && !position_state.nil?
      when :double_step
        front_position_row = @color == 'white' ? (current_row + 1) : (current_row - 1)
        front_position_state = board.position_state(front_position_row, current_col)

        moves << [row, column] if position_state.nil? && front_position_state.nil? && !@moved
      end
    end

    moves
  end

  def update_attacking_fields
    fields_being_attacked = []

    row, left_column, right_column = if white?
                                       [current_row + 1, current_col - 1, current_col + 1]
                                     else
                                       [current_row - 1, current_col - 1, current_col + 1]
                                     end


    fields_being_attacked << [row, right_column] unless Piece.out_of_bounds?(row, right_column)
    fields_being_attacked << [row, left_column] unless Piece.out_of_bounds?(row, left_column)

    @attacking_fields = fields_being_attacked
  end

  private

  def set_move_set(color)
    if color == 'white'
      {
        one_step:      [0, 1],
        double_step:   [0, 2],
        capture_left:  [-1, 1],
        capture_right: [1, 1]
      }
    else
      {
        one_step:      [0, -1],
        double_step:   [0, -2],
        capture_left:  [1, -1],
        capture_right: [-1, -1]
      }
    end
  end
end
