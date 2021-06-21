# frozen_string_literal: true

class Piece
  attr_reader :initial_position, :image, :color
  attr_accessor :current_position

  # TODO: imagem na peça? melhor nao
  def initialize(initial_position, color, image)
    @initial_position = initial_position
    @current_position = initial_position
    @color = color
    @image = image
  end

  def white?
    @color == 'white'
  end

  def  current_col
    @current_position[1]
  end

  def current_row
    @current_position[0]
  end

  def find_moves(board)
    []
  end
end
