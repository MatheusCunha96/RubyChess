# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/piece'
require 'domain/position'

describe Piece do
  let(:color) { 'white' }
  let(:piece) { Piece.new(color) }

  describe 'new piece' do
    it 'current position must initialize nil' do
      expect(piece.current_position).to be_nil
    end

    it 'must have color' do
      expect(piece.color).to eql(color)
    end
  end

  describe '#white?' do
    it 'return false if piece black' do
      piece = Piece.new('black')
      expect(piece.white?).to be false
    end

    it 'return true if piece white' do
      piece = Piece.new('white')
      expect(piece.white?).to be true
    end
  end

  describe '#current_col' do
    it 'return nil for piece current position nil' do
      piece = Piece.new('white')

      expect(piece.current_col).to be_nil
    end

    it 'return piece current column' do
      piece = Piece.new('white')
      piece.current_position = [1, 2]

      expect(piece.current_col).to eql(2)
    end
  end

  describe '#current_row' do
    it 'return nil for piece current position nil' do
      piece = Piece.new('white')

      expect(piece.current_row).to be_nil
    end

    it 'return piece current column' do
      piece = Piece.new('white')
      piece.current_position = [1, 2]

      expect(piece.current_row).to eql(1)
    end
  end

  describe '#update_attacking_fields' do
    it 'update attacking fields with possible moves' do
      piece = Piece.new('white')
      possible_moves = [[2, 4], [3, 5], [2, 5]]
      piece.possible_moves = possible_moves

      piece.update_attacking_fields

      expect(piece.attacking_fields).to match_array(possible_moves)
    end
  end
end
