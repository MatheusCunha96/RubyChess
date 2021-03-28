# frozen_string_literal: true

require_relative 'piece'

class Bishop < Piece
  attr_accessor :image

  def initialize(initial_position, color)
    super(initial_position, color, color == 'white' ? '♝' : '♗')
  end
end
