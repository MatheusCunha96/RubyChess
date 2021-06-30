# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/knight'
require 'domain/board'
require 'domain/position'

describe Knight do
  describe '.new' do
    let(:color) { 'white' }
    let(:knight) { Knight.new(color) }

    it 'current position must initialize nil' do
      expect(knight.current_position).to be_nil
    end

    it 'must have color' do
      expect(knight.color).to eql(color)
    end

    describe 'image' do
      it 'should be white if white knight' do
        knight = Knight.new('white')
        expect(knight.image).to eql('♞')
      end

      it 'should be black if black knight' do
        knight = Knight.new('black')
        expect(knight.image).to eql('♘')
      end
    end

    describe 'possible moves' do
      it 'must have correct possibles move' do
        knight = Knight.new('white')
        expect(knight.possible_moves).to eql(
          [[2, 1],
           [2, -1],
           [1, 2],
           [-1, 2],
           [-2, -1],
           [-2, 1],
           [-1, -2],
           [1, -2]]
        )
      end
    end
  end

  describe '#find_moves' do
    let(:board) { Board.new }

    after { reset_board(board) }

    it 'has two moves from initial position' do
      expected_moves = [[2, 5], [2, 7]]
      knight = board.positions[0][6].piece
      moves = knight.find_moves(board)

      moves.each do |move|
        expect(expected_moves).to include(move)
      end
    end

    it 'can move to place with different color piece' do
      expected_moves = [[5, 6], [3, 6], [6, 5], [6, 3], [3, 2], [5, 2], [2, 3], [2, 5]]
      move_piece(board, [0, 6], [4, 4])

      knight = board.positions[4][4].piece
      moves = knight.find_moves(board)

      moves.each do |move|
        expect(expected_moves).to include(move)
      end
    end

    it 'cant move to place with same color piece' do
      expected_moves = [[4, 6], [2, 6], [5, 5], [5, 3], [2, 2], [4, 2]]
      move_piece(board, [0, 6], [3, 4])

      knight = board.positions[3][4].piece
      moves = knight.find_moves(board)

      moves.each do |move|
        expect(expected_moves).to include(move)
      end

    end
  end
end
