# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  attr_accessor :image

  def initialize(initial_position, color)
    @image = 'p'
    super(initial_position, color, @image)
  end
end
