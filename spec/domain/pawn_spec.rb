# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/pawn'
require 'domain/position'

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
  end
end
