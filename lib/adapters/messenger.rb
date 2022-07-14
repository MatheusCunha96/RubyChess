# frozen_string_literal: true

class Messenger
  # TODO: put every log message/input request inside this class
  # TODO: split in input class and output class
  class << self
    def ask_player_name(color)
      puts "Enter player #{color} name: "
      $stdin.gets.chomp
    end

    def notify_player_turn(name)
      puts "Player #{name} turn."
    end

    def ask_player_move
      puts 'Please, write your move in format: [Letter][Number] to [Letter][Number] (ex. e2 to e3).'
      $stdin.gets.chomp.downcase
    end

    def notify_not_possible_move(possible_moves)
      puts "This piece can move only for #{possible_moves}"
    end

    def notify_empty_position
      puts 'The origin position is empty, there is no piece.'
    end

    def notify_opponent_piece
      puts 'That is not your piece, try again.'
    end

    def notify_move_king_check
      puts 'This move will leave your king in check!'
    end
  end
end
