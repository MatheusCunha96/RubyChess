# frozen_string_literal: true

require_relative 'board'
require_relative '../adapters/messenger'

class Move
  class << self
    def execute(player, move, board)
      orig = move[0]
      dest = move[1]

      orig_position = board.positions[orig[0]][orig[1]]
      dest_position = board.positions[dest[0]][dest[1]]

      return false unless validate(player, orig_position, dest_position)

      board.move_piece(orig_position, dest_position)
    end

    def update_pieces_possible_moves(board)
      board.positions.each do |row|
        row.each do |position|
          current_piece = position.piece

          next if current_piece.nil?

          current_piece.possible_moves = current_piece.find_moves(board)
        end
      end
    end

    private

    def validate(player, orig, dest)
      moved_piece = orig.piece

      if moved_piece.nil?
        Messenger.notify_empty_position
        return false
      end

      if moved_piece.color != player.color
        Messenger.notify_opponent_piece
        return false
      end

      possible_moves = moved_piece.possible_moves

      unless possible_moves.include?(dest.as_array)
        Messenger.notify_not_possible_move(possible_moves)
        return false
      end

      true
    end
  end
end
