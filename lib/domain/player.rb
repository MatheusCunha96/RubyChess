# frozen_string_literal: true

require_relative 'position'

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def move
    puts 'Write your move in format: [Letter][Number] to [Letter][Number] (ex. e2 to e3).'
    move = STDIN.gets.chomp.downcase

    until move =~ move_format
      puts 'Please, write your move in correct format (ex. e2 to e3).'
      move = STDIN.gets.chomp.downcase
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

      Position.new(row, col)
    end
  end
end
