# frozen_string_literal: true

class Position
  attr_accessor :row, :col

  def initialize(row, col)
    @row = row
    @col = col
  end

  def to_a
    [row, col]
  end
end
