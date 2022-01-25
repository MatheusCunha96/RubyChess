# frozen_string_literal: true

class Position
  attr_accessor :row, :col, :piece, :being_attacked

  def initialize(row, col)
    @row = row
    @col = col
    @piece = nil
    @being_attacked = false
  end

  def piece=(piece)
    @piece = piece
    piece.current_position = as_array
  end

  def remove_piece
    @piece = nil
  end

  def as_array
    [@row, @col]
  end
end
