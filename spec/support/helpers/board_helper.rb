module Helpers
  module Board
    def move_piece(board, orig, dest)
      orig_position = board.positions[orig[0]][orig[1]]
      dest_position = board.positions[dest[0]][dest[1]]

      board.send(:move_piece, orig_position, dest_position)
    end

    def reset_board(board)
      board.positions = Array.new(8) { |row| Array.new(8) { |col| Position.new(row, col) } }
      board.send(:set_initial_state)
    end
  end
end
