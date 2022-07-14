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

      return false unless validate(player, board, orig_position, dest_position)

      board.move_piece(orig_position, dest_position)
      board.update_positions_state
      board.update_pieces_possible_moves
      board.update_positions_being_attacked
    end

    private

    def validate(player, board, orig, dest)
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

      unless valid_future_board?(board, player, orig, dest)
        Messenger.notify_move_king_check
        return false
      end

      true
    end

    def valid_future_board?(board, player, orig, dest)
      board_copy = board.clone

      board_copy.move_piece(orig, dest)
      board_copy.update_positions_state
      board_copy.update_pieces_possible_moves
      board_copy.update_positions_being_attacked
      !board_copy.player_checked?(player)
    end
  end
end
