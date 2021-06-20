# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/pawn'
require 'domain/position'
require 'domain/board'

describe Pawn do
  let(:initial_position) { Position.new(1, 0) }

  describe 'new' do
    let(:color) { 'white' }
    let(:pawn) { Pawn.new(initial_position, color) }

    it 'must have initial position' do
      expect(pawn.initial_position.row).to eql(initial_position.row)
      expect(pawn.initial_position.col).to eql(initial_position.col)
    end

    it 'current position must initialize equal to initial position' do
      expect(pawn.current_position.row).to eql(initial_position.row)
      expect(pawn.current_position.col).to eql(initial_position.col)
    end

    it 'must have color' do
      expect(pawn.color).to eql(color)
    end

    describe 'image' do
      it 'should be white if white pawn' do
        pawn = Pawn.new(initial_position, 'white')
        expect(pawn.image).to eql('♟')
      end

      it 'should be black if black pawn' do
        pawn = Pawn.new(initial_position, 'black')
        expect(pawn.image).to eql('♙')
      end
    end

    describe 'possible moves' do
      context 'when white' do
        it 'must have correct possibles move' do
          pawn = Pawn.new(initial_position, 'white')
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
          pawn = Pawn.new(initial_position, 'black')
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
      black_dest = Position.new(2,4)

      white_orig = Position.new(1,7)
      white_dest = Position.new(2,0)

      board.send(:move_piece, black_orig, black_dest)
      board.send(:move_piece, white_orig, white_dest)
    end

    context 'when one step' do
      it 'success if next position empty' do
        pawn = board.positions[1][1]
        moves = pawn.find_moves(board)

        expect(moves).to include([2,1])
      end

      it 'fail if next position no empty' do
        pawn = board.positions[1][4]
        moves = pawn.find_moves(board)

        expect(moves).to be_empty
      end
    end

    context 'when capture left' do
      it 'success if contains piece from different color' do
        expected_moves = [[2,4], [2,5]]
        pawn = board.positions[1][5]
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end

      it 'fail if empty' do
        expected_moves = [[2,4], [2,3]]
        pawn = board.positions[1][3]
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end

      it 'fail if contains piece from same color' do
        expected_moves = [[2,1]]
        pawn = board.positions[1][1]
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end
    end
  end
end
