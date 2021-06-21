# frozen_string_literal: true

class Position
  attr_accessor :row, :col, :piece

  def initialize(row, col)
    @row = row
    @col = col
    @piece = nil
  end

  def to_a
    [row, col]
  end
end
