# frozen_string_literal: true

class Position
  attr_accessor :row, :col, :piece, :being_attacked_by

  def initialize(row, col)
    @row = row
    @col = col
    @piece = nil
    @being_attacked_by = { white: false, black: false }
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

  def being_attacked?
    being_attacked_by_white? || being_attacked_by_black?
  end

  def being_attacked_by_white?
    @being_attacked_by[:white]
  end

  def being_attacked_by_black?
    @being_attacked_by[:black]
  end
end
