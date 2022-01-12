# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/bishop'
require 'domain/position'
require 'domain/board'

describe Bishop do
  let(:board) { Board.new }

  after { reset_board(board) }

  describe '.new' do
    let(:color) { 'white' }
    let(:bishop) { Bishop.new(color) }

    it 'current position must initialize nil' do
      expect(bishop.current_position).to be_nil
    end

    it 'must have color' do
      expect(bishop.color).to eql(color)
    end

    describe 'image' do
      it 'should be white if white bishop' do
        bishop = Bishop.new('white')
        expect(bishop.image).to eql('♝')
      end

      it 'should be black if black bishop' do
        bishop = Bishop.new('black')
        expect(bishop.image).to eql('♗')
      end
    end

    describe 'move_set' do
      it 'must have correct possibles move' do
        bishop = Bishop.new('white')
        expect(bishop.move_set).to eql(
          [[1, 1],
           [1, -1],
           [-1, 1],
           [-1, -1]]
        )
      end
    end
  end

  describe '#find_moves' do
    it 'has no moves from initial position' do
      bishop = board.positions[0][5].piece
      moves = bishop.find_moves(board)

      expect(moves).to be_empty
    end

    it 'can move to position with different color piece, but cant to position with same color piece ' do
      expected_moves = [[5, 5], [6, 6], [3, 5], [2, 6], [5, 3], [6, 2], [3, 3], [2, 2]]
      move_piece(board, [0, 5], [4, 4])
      bishop = board.positions[4][4].piece
      moves = bishop.find_moves(board)

      moves.each do |move|
        expect(expected_moves).to include(move)
      end
    end
  end

end

