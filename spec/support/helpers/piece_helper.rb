module Helpers
  module Piece
    def mock_piece_possible_moves(piece, moves)
      allow(piece).to receive(:possible_moves).and_return(moves)
    end
  end
end
