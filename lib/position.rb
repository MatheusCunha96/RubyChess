# frozen_string_literal: true

class Position
  attr_accessor :row, :col

  def initialize(row, col, piece = nil)
    @row = row
    @col = col
  end
end
