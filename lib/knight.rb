# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  attr_accessor :image

  def initialize(initial_position, color)
    @image = 'c'
    super(initial_position, color, @image)
  end
end
