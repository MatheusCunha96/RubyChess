# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece
  attr_accessor :image

  def initialize(initial_position, color)
    @image = 't'
    super(initial_position, color, @image)
  end
end
