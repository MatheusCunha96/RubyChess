# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/rook'
require 'domain/position'
require 'domain/board'

describe Rook do
  let(:board) { Board.new }

  after { reset_board(board) }

  describe '.new' do
    let(:color) { 'white' }
    let(:rook) { Rook.new(color) }

    it 'current position must initialize nil' do
      expect(rook.current_position).to be_nil
    end

    it 'must have color' do
      expect(rook.color).to eql(color)
    end

    describe 'image' do
      it 'should be white if white rook' do
        rook = Rook.new('white')
        expect(rook.image).to eql('♜')
      end

      it 'should be black if black rook' do
        rook = Rook.new('black')
        expect(rook.image).to eql('♖')
      end
    end

    describe 'move_set' do
      it 'must have correct possibles move' do
        rook = Rook.new('white')
        expect(rook.move_set).to eql(
          [[0, 1],
           [0, -1],
           [1, 0],
           [-1, 0]]
        )
      end
    end

    describe 'moved' do
      it 'initializes with false' do
        rook = board.positions[0][7].piece
        expect(rook.moved).to be_falsey
      end

      it 'set to true after move rook' do
        rook = board.positions[0][7].piece

        move_piece(board, [1, 7], [2, 7])
        move_piece(board, [0, 7], [1, 7])

        expect(rook.moved).to be_truthy
      end
    end
  end

  describe '#find_moves' do
    it 'has no moves from initial position' do
      rook = board.positions[0][7].piece
      moves = rook.find_moves(board)

      expect(moves).to be_empty
    end

    it 'can move to position with different color piece, but cant to position with same color piece ' do
      expected_moves = [[6, 5], [4, 5], [3, 5], [2, 5], [5, 6], [5, 7], [5, 4], [5, 3], [5, 2], [5, 1], [5, 0]]
      move_piece(board, [0, 7], [5, 5])
      rook = board.positions[5][5].piece
      moves = rook.find_moves(board)

      moves.each do |move|
        expect(expected_moves).to include(move)
      end
    end
  end
end
