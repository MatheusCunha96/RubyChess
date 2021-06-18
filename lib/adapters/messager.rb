# frozen_string_literal: true

class Messager
  def self.not_possible_move(possible_moves)
    puts "This piece can move only for #{possible_moves}"
  end
end
