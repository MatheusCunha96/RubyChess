# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/pawn'
require 'domain/position'
require 'domain/board'

describe Pawn do
  describe 'new' do
    let(:color) { 'white' }
    let(:pawn) { Pawn.new(color) }

    it 'current position must initialize nil' do
      expect(pawn.current_position).to be_nil
    end

    it 'must have color' do
      expect(pawn.color).to eql(color)
    end

    describe 'image' do
      it 'should be white if white pawn' do
        pawn = Pawn.new('white')
        expect(pawn.image).to eql('♟')
      end

      it 'should be black if black pawn' do
        pawn = Pawn.new('black')
        expect(pawn.image).to eql('♙')
      end
    end

    describe 'possible moves' do
      context 'when white' do
        it 'must have correct possibles move' do
          pawn = Pawn.new('white')
          expect(pawn.possible_moves).to eql({
            one_step:      [0,1],
            double_step:   [0,2],
            capture_left:  [-1,1],
            capture_right: [1,1]
          }
          )
        end
      end

      context 'when black' do
        it 'must have correct possibles move' do
          pawn = Pawn.new('black')
          expect(pawn.possible_moves).to eql({
            one_step:      [0,-1],
            double_step:   [0,-2],
            capture_left:  [1,-1],
            capture_right: [-1,-1]
          }
          )
        end
      end
    end
  end

  describe '.find_moves' do
    let(:board) { Board.new }

    before do
      black_orig = Position.new(6,4)
      black_orig.piece = Pawn.new('black')
      black_dest = Position.new(2,4)

      white_orig = Position.new(1,7)
      white_orig.piece = Pawn.new('white')
      white_dest = Position.new(2,0)

      board.send(:move_piece, black_orig, black_dest)
      board.send(:move_piece, white_orig, white_dest)
    end

    context 'when one step' do
      it 'success if next position empty' do
        pawn = board.positions[1][1].piece
        moves = pawn.find_moves(board)

        expect(moves).to include([2,1])
      end

      it 'fail if next position not empty' do
        pawn = board.positions[1][4].piece
        moves = pawn.find_moves(board)

        expect(moves).to be_empty
      end
    end

    context 'when capture left' do
      it 'success if contains piece from different color' do
        expected_moves = [[2,4], [2,5]]
        pawn = board.positions[1][5].piece
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end

      it 'fail if empty' do
        expected_moves = [[2,4], [2,3]]
        pawn = board.positions[1][3].piece
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end

      it 'fail if contains piece from same color' do
        expected_moves = [[2,1]]
        pawn = board.positions[1][1].piece
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end
    end
  end
end
