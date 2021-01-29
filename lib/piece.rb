# frozen_string_literal: true

class Piece
  attr_reader :initial_position, :image, :color
  attr_accessor :current_position

  def initialize(initial_position, color, image)
    @initial_position = initial_position
    @current_position = initial_position
    @color = color
    @image = image
  end

  def white?
    @color == 'white'
  end
end
