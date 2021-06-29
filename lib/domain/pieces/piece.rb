# frozen_string_literal: true

class Piece
  attr_reader :initial_position, :image, :color
  attr_accessor :current_position

  # TODO: better remove image from piece, thats drawer responsability
  def initialize(color, image)
    @current_position = nil
    @color = color
    @image = image
  end

  def white?
    @color == 'white'
  end

  def current_col
    @current_position&.dig(1)
  end

  def current_row
    @current_position&.dig(0)
  end

  def find_moves(board)
    []
  end
end
