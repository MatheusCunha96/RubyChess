# frozen_string_literal: true

class Position
  attr_accessor :row, :col, :piece

  def initialize(row, col)
    @row = row
    @col = col
    @piece = nil
  end

  def piece=(piece)
    @piece = piece
    piece.current_position = as_array
  end

  def remove_piece
    @piece = nil
  end

  private

  def as_array
    [@row, @col]
  end
end
