# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/piece'
require 'domain/position'

describe Piece do
  let(:initial_position) { Position.new(1, 0) }
  let(:color) { 'white' }
  let(:image) { 'p' }
  let(:piece) { Piece.new(initial_position, color, image) }

  describe 'new piece' do
    it 'must have initial position' do
      expect(piece.initial_position.row).to eql(initial_position.row)
      expect(piece.initial_position.col).to eql(initial_position.col)
    end

    it 'current position must initialize equal to initial position' do
      expect(piece.current_position.row).to eql(initial_position.row)
      expect(piece.current_position.col).to eql(initial_position.col)
    end

    it 'must have color' do
      expect(piece.color).to eql(color)
    end

    it 'must have image' do
      expect(piece.image).to eql(image)
    end
  end

  describe 'white?' do
    it 'return false if piece black' do
      piece = Piece.new(initial_position, 'black', image)
      expect(piece.white?).to be false
    end

    it 'return true if piece white' do
      piece = Piece.new(initial_position, 'white', image)
      expect(piece.white?).to be true
    end
  end
end
