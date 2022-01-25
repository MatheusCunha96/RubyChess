# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/piece'
require 'domain/position'

describe Piece do
  let(:color) { 'white' }
  let(:image) { 'p' }
  let(:piece) { Piece.new(color, image) }

  describe 'new piece' do
    it 'current position must initialize nil' do
      expect(piece.current_position).to be_nil
    end

    it 'must have color' do
      expect(piece.color).to eql(color)
    end

    it 'must have image' do
      expect(piece.image).to eql(image)
    end
  end

  describe '#white?' do
    it 'return false if piece black' do
      piece = Piece.new('black', image)
      expect(piece.white?).to be false
    end

    it 'return true if piece white' do
      piece = Piece.new('white', image)
      expect(piece.white?).to be true
    end
  end

  describe '#current_col' do
    it 'return nil for piece current position nil' do
      piece = Piece.new('white', image)

      expect(piece.current_col).to be_nil
    end

    it 'return piece current column' do
      piece = Piece.new('white', image)
      piece.current_position = [1, 2]

      expect(piece.current_col).to eql(2)
    end
  end

  describe '#current_row' do
    it 'return nil for piece current position nil' do
      piece = Piece.new('white', image)

      expect(piece.current_row).to be_nil
    end

    it 'return piece current column' do
      piece = Piece.new('white', image)
      piece.current_position = [1, 2]

      expect(piece.current_row).to eql(1)
    end
  end
end
