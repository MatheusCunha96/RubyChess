# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/rook'
require 'domain/position'
require 'domain/board'

describe Rook do
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

    describe 'possible moves' do
      it 'must have correct possibles move' do
        rook = Rook.new('white')
        expect(rook.possible_moves).to eql([
          [0,1],
          [0,-1],
          [1,0],
          [-1,0],
        ])
      end
    end
  end

  describe '#find_moves' do
    let (:board) { Board.new }

    after { reset_board(board) }

    before do
      move_piece(board, [0,7], [5,5])
    end

    it ' ' do
      expected_moves = [[2,6], [2,8]]
      rook = board.positions[5][5].piece
      moves = rook.find_moves(board)

      moves.each do |move|
        expect(expected_moves).to include(move)
      end
    end
  end

end
