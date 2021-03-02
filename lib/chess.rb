# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require 'byebug'

class Chess
  attr_accessor :board, :turn, :player_white, :player_black

  def initialize
    @board = Board.new
    @turn = 0
    @player_white = nil
    @player_black = nil
  end

  def play
    create_players

    until finish_condition?
      current_player = (@turn % 2).zero? ? @player_white : @player_black

      # validate move
      move = current_player.move
      debugger

      @turn += 1
    end
  end

  private

  def create_players
    puts 'Enter player white name: '
    player_white = STDIN.gets.chomp

    puts 'Enter player black name: '
    player_black = STDIN.gets.chomp

    @player_white = Player.new(player_white)
    @player_black = Player.new(player_black)
  end

  def finish_condition?
    # checkmate
    # dead position ( king vs king; king vs king and bishop; king vs king and knight; king and bishop vs king and bishop if bishop from squares of same color)
    # stalemate
    checkmate?
  end

  def checkmate?
    false
  end
end
