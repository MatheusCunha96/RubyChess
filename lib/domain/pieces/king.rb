# frozen_string_literal: true

require_relative 'piece'

class King < Piece
  attr_accessor :image

  def initialize(color)
    super(color, color == 'white' ? '♚' : '♔')
  end
end
