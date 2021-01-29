# frozen_string_literal: true

require_relative 'board'
require 'byebug'

class Chess
  attr_accessor :board, :turn

  def initialize
    @board = Board.new
  end
end

chess = Chess.new
chess.board.display
