# frozen_string_literal: true

class Messenger
  # TODO: put every log message/input request inside this class
  def self.not_possible_move(possible_moves)
    puts "This piece can move only for #{possible_moves}"
  end
end
