# frozen_string_literal: true

require 'spec_helper'
require 'domain/board'

describe Board do
  let(:board) { Board.new }

  it 'has 8x8 size' do
    expect(board.positions).to match_array(Array.new(8) { Array.new(8, anything) })
  end

  describe 'initial state' do
    describe 'white side' do
      it 'has 8 pawns in correct position' do
        white_pawns_row = board.positions[1]

        white_pawns_row.each do |piece|
          expect(piece).to be_instance_of(Pawn)
          expect(piece.color).to be('white')
        end
      end

      it 'has 2 rooks' do
        white_rooks = [board.positions[0][0], board.positions[0][7]]

        white_rooks.each do |piece|
          expect(piece).to be_instance_of(Rook)
          expect(piece.color).to be('white')
        end
      end

      it 'has 2 knights' do
        white_knights = [board.positions[0][1], board.positions[0][6]]

        white_knights.each do |piece|
          expect(piece).to be_instance_of(Knight)
          expect(piece.color).to be('white')
        end
      end

      it 'has 2 bishops' do
        white_bishops = [board.positions[0][2], board.positions[0][5]]

        white_bishops.each do |piece|
          expect(piece).to be_instance_of(Bishop)
          expect(piece.color).to be('white')
        end
      end

      it 'has 1 queen' do
        white_queen = board.positions[0][3]

        expect(white_queen).to be_instance_of(Queen)
        expect(white_queen.color).to be('white')
      end

      it 'has 1 king' do
        white_king = board.positions[0][4]

        expect(white_king).to be_instance_of(King)
        expect(white_king.color).to be('white')
      end
    end

    describe 'black side' do
      it 'has 8 pawns' do
        black_pawns_row = board.positions[6]

        black_pawns_row.each do |piece|
          expect(piece).to be_instance_of(Pawn)
          expect(piece.color).to be('black')
        end
      end

      it 'has 2 rooks' do
        black_rooks = [board.positions[7][0], board.positions[7][7]]

        black_rooks.each do |piece|
          expect(piece).to be_instance_of(Rook)
          expect(piece.color).to be('black')
        end
      end

      it 'has 2 knights' do
        black_knights = [board.positions[7][1], board.positions[7][6]]

        black_knights.each do |piece|
          expect(piece).to be_instance_of(Knight)
          expect(piece.color).to be('black')
        end
      end

      it 'has 2 bishops' do
        black_bishops = [board.positions[7][2], board.positions[7][5]]

        black_bishops.each do |piece|
          expect(piece).to be_instance_of(Bishop)
          expect(piece.color).to be('black')
        end
      end

      it 'has 1 queen' do
        black_queen = board.positions[7][3]

        expect(black_queen).to be_instance_of(Queen)
        expect(black_queen.color).to be('black')
      end

      it 'has 1 king' do
        black_king = board.positions[7][4]

        expect(black_king).to be_instance_of(King)
        expect(black_king.color).to be('black')
      end
    end
  end

  describe '.update_positions' do
    it 'move piece from orig to dest' do
      orig = Position.new(1, 5)
      dest = Position.new(2, 5)
      board.update_positions(orig, dest)

      expect(board.positions[1][5]).to be_nil
      expect(board.positions[2][5]).to be_instance_of(Pawn)
    end
  end

end
