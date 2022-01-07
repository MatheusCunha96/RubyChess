# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative '../adapters/messenger'
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
      move_succeed = false
      current_player = (@turn % 2).zero? ? @player_white : @player_black

      Messenger.notify_player_turn(current_player.name)
      until move_succeed
        move = current_player.move
        move_succeed = @board.execute_move(current_player, move)
      end

      @turn += 1
      @board.display
    end
  end

  private

  def create_players
    player_white = Messenger.ask_player_name('white')
    player_black = Messenger.ask_player_name('black')

    @player_white = Player.new(player_white, 'white')
    @player_black = Player.new(player_black, 'black')
  end

  def finish_condition?
    # checkmate
    # dead position - king vs king;
    #               - king vs king and bishop;
    #               - king vs king and knight;
    #               - king and bishop vs king and bishop if bishop from squares of same color)
    # stalemate
    checkmate?
  end

  def checkmate?
    false
  end
end
