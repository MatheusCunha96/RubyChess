# frozen_string_literal: true

require_relative 'position'
require_relative '../adapters/messenger'

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def move
    move = Messenger.ask_player_move

    until move =~ move_format
      move = Messenger.ask_player_move
    end

    move_to_position(move_format.match(move).captures)
  end

  private

  def move_format
    /^([a-h][1-8])\s{1}to\s{1}([a-h][1-8])$/
  end

  def move_to_position(move)
    move.map do |position|
      position_splitted = position.split('')
      col = position_splitted[0].bytes.first - 97
      row = position_splitted[1].to_i - 1

      [row,col]
    end
  end
end
