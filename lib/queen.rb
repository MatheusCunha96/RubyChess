# frozen_string_literal: true

require_relative 'piece'

class Queen < Piece
  attr_accessor :image

  def initialize(initial_position, color)
    @image = 'q'
    super(initial_position, color, @image)
  end
end
