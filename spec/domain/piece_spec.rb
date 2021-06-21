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

  describe '.white?' do
    it 'return false if piece black' do
      piece = Piece.new('black', image)
      expect(piece.white?).to be false
    end

    it 'return true if piece white' do
      piece = Piece.new('white', image)
      expect(piece.white?).to be true
    end
  end
end
