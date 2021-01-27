# frozen_string_literal: true

require_relative 'board'
require 'byebug'

class Chess
  attr_accessor :board, :turn

  def initialize
    @board = Board.new
    @turn = 'a'
  end
end

chess = Chess.new
debugger
p 'n'
