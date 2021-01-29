# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece
  attr_accessor :image

  def initialize(initial_position, color)
    super(initial_position, color, color == 'white' ? '♜' : '♖')
  end
end
