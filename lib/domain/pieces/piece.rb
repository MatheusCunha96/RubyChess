# frozen_string_literal: true

class Piece
  attr_reader :initial_position, :image, :color, :attacking_fields
  attr_accessor :current_position, :possible_moves

  # TODO: better remove image from piece, thats drawer responsability
  def initialize(color, image)
    @current_position = nil
    @possible_moves = []
    @attacking_fields = []
    @color = color
    @image = image
  end

  def self.out_of_bounds?(row, column)
    column > 7 || column.negative? || row > 7 || row.negative?
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

  def update_attacking_fields
    @attacking_fields = @possible_moves
  end
end
