# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/queen'
require 'domain/position'
require 'domain/board'

describe Queen do
  let(:board) { Board.new }

  after { reset_board(board) }

  describe '.new' do
    let(:color) { 'white' }
    let(:queen) { Queen.new(color) }

    it 'current position must initialize nil' do
      expect(queen.current_position).to be_nil
    end

    it 'must have color' do
      expect(queen.color).to eql(color)
    end

    describe 'image' do
      it 'should be white if white queen' do
        queen = Queen.new('white')
        expect(queen.image).to eql('♛')
      end

      it 'should be black if black queen' do
        queen = Queen.new('black')
        expect(queen.image).to eql('♕')
      end
    end

    describe 'directions' do
      it 'must have correct possibles move' do
        queen = Queen.new('white')
        expect(queen.directions).to eql(
          [[0, 1],
           [0, -1],
           [1, 0],
           [-1, 0],
           [1, 1],
           [1, -1],
           [-1, 1],
           [-1, -1]]
        )
      end
    end
  end

  describe '#find_moves' do
    it 'has no moves from initial position' do
      queen= board.positions[0][3].piece
      moves = queen.find_moves(board)

      expect(moves).to be_empty
    end

    it 'can move to position with different color piece, but cant to position with same color piece ' do
      expected_moves = [[5, 4], [6, 4], [3, 4], [2, 4], [4, 5], [4, 6], [4, 7], [4, 3], [4, 2], [4, 1], [4, 0], [5, 5], [6, 6], [3, 5], [2, 6], [5, 3], [6, 2], [3, 3], [2, 2]]
      move_piece(board, [0, 3], [4, 4])
      queen = board.positions[4][4].piece
      moves = queen.find_moves(board)

      moves.each do |move|
        expect(expected_moves).to include(move)
      end
    end
  end

end
