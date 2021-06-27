# frozen_string_literal: true

class Messenger
  # TODO: put every log message/input request inside this class
  def self.ask_player_name(color)
    puts "Enter player #{color} name: "
    STDIN.gets.chomp
  end

  def self.notice_player_turn(name)
    puts "Player #{name} turn."
  end

  def self.ask_player_move
    puts 'Please, write your move in format: [Letter][Number] to [Letter][Number] (ex. e2 to e3).'
    STDIN.gets.chomp.downcase
  end

  def self.not_possible_move(possible_moves)
    puts "This piece can move only for #{possible_moves}"
  end
end
