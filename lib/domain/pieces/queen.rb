# frozen_string_literal: true

require_relative 'piece'

class Queen < Piece
  attr_accessor :image
  attr_reader :directions

  def initialize(color)
    @directions = set_directions

    super(color, color == 'white' ? '♛' : '♕')
  end

  private

  def set_directions
    [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0],
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]

  end
end
