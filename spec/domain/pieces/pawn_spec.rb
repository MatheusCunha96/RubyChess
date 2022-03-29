# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/pawn'
require 'domain/position'
require 'domain/board'

describe Pawn do
  describe '.new' do
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

    describe 'move set' do
      context 'when white' do
        it 'must have correct move set' do
          pawn = Pawn.new('white')
          expect(pawn.move_set).to eql({
              one_step:      [0, 1],
              double_step:   [0, 2],
              capture_left:  [-1, 1],
              capture_right: [1, 1]
            }
          )
        end
      end

      context 'when black' do
        it 'must have correct move set' do
          pawn = Pawn.new('black')
          expect(pawn.move_set).to eql({
            one_step:      [0, -1],
            double_step:   [0, -2],
            capture_left:  [1, -1],
            capture_right: [-1, -1]
          }
          )
        end
      end
    end
  end

  describe '#find_moves' do
    let(:board) { Board.new }

    after { reset_board(board) }

    context 'when one step' do
      before do
        black_orig = Position.new(6, 4)
        black_orig.piece = Pawn.new('black')
        black_dest = Position.new(2, 4)

        board.send(:move_piece, black_orig, black_dest)
      end

      it 'success if next position empty' do
        pawn = board.positions[1][1].piece
        moves = pawn.find_moves(board)

        expect(moves).to include([2, 1])
      end

      it 'fail if next position not empty' do
        pawn = board.positions[1][4].piece
        moves = pawn.find_moves(board)

        expect(moves).to be_empty
      end
    end

    context 'when capture left' do
      before do
        black_orig = Position.new(6, 4)
        black_orig.piece = Pawn.new('black')
        black_dest = Position.new(2, 4)

        white_orig = Position.new(1, 7)
        white_orig.piece = Pawn.new('white')
        white_dest = Position.new(2, 0)

        board.send(:move_piece, black_orig, black_dest)
        board.send(:move_piece, white_orig, white_dest)
      end

      it 'success if contains piece from different color' do
        expected_moves = [[2, 4], [3, 5], [2, 5]]
        pawn = board.positions[1][5].piece
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end

      it 'fail if empty' do
        expected_moves = [[2, 2], [3, 2]]
        pawn = board.positions[1][2].piece
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end

      it 'fail if contains piece from same color' do
        expected_moves = [[2, 1], [3, 1]]
        pawn = board.positions[1][1].piece
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end
    end

    context 'when capture right' do
      before do
        black_orig = Position.new(6, 4)
        black_orig.piece = Pawn.new('black')
        black_dest = Position.new(2, 4)

        white_orig = Position.new(1, 7)
        white_orig.piece = Pawn.new('white')
        white_dest = Position.new(2, 7)

        board.send(:move_piece, black_orig, black_dest)
        board.send(:move_piece, white_orig, white_dest)
      end

      it 'success if contains piece from different color' do
        expected_moves = [[2, 4], [2, 3], [3, 3]]
        pawn = board.positions[1][3].piece
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end

      it 'fail if empty' do
        expected_moves = [[2, 2], [3, 2]]
        pawn = board.positions[1][2].piece
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end

      it 'fail if contains piece from same color' do
        expected_moves = [[2, 6], [3, 6]]
        pawn = board.positions[1][6].piece
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end
    end

    context 'when double step' do
      before do
        first_black_orig = Position.new(6, 4)
        first_black_orig.piece = Pawn.new('black')
        first_black_dest = Position.new(2, 4)

        second_black_orig = Position.new(6, 5)
        second_black_orig.piece = Pawn.new('black')
        second_black_dest = Position.new(3, 7)

        white_orig = Position.new(1, 2)
        white_orig.piece = Pawn.new('white')
        white_dest = Position.new(2, 2)

        board.send(:move_piece, first_black_orig, first_black_dest)
        board.send(:move_piece, second_black_orig, second_black_dest)
        board.send(:move_piece, white_orig, white_dest)
      end

      it 'success if front position empty and double front position empty' do
        expected_moves = [[2, 1], [3, 1]]
        pawn = board.positions[1][1].piece
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end

      it 'fail if front position not empty' do
        pawn = board.positions[1][4].piece
        moves = pawn.find_moves(board)

        expect(moves).to be_empty
      end

      it 'fail if double front position not empty' do
        expected_moves = [[2, 7]]
        pawn = board.positions[1][7].piece
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end

      it 'fail if piece already moved' do
        expected_moves = [[3, 2]]
        pawn = board.positions[2][2].piece
        moves = pawn.find_moves(board)

        moves.each do |move|
          expect(expected_moves).to include(move)
        end
      end
    end
  end

  describe '#update_attacking_fields' do
    it 'update attacking fields with upper left and right edges' do
      expected_attacking_fields = [[2, 1], [2, 3]]
      position = Position.new(1, 2)
      position.piece = Pawn.new('white')

      position.piece.update_attacking_fields

      expect(position.piece.attacking_fields).to match_array(expected_attacking_fields)
    end
  end
end
