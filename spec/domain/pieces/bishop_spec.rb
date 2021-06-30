# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/bishop'
require 'domain/position'
require 'domain/board'

describe Bishop do
  let(:board) { Board.new }

  after { reset_board(board) }

  describe '.new' do
    let(:color) { 'white' }
    let(:bishop) { Bishop.new(color) }

    it 'current position must initialize nil' do
      expect(bishop.current_position).to be_nil
    end

    it 'must have color' do
      expect(bishop.color).to eql(color)
    end

    describe 'image' do
      it 'should be white if white bishop' do
        bishop = Bishop.new('white')
        expect(bishop.image).to eql('♝')
      end

      it 'should be black if black bishop' do
        bishop = Bishop.new('black')
        expect(bishop.image).to eql('♗')
      end
    end

    describe 'directions' do
      it 'must have correct possibles move' do
        bishop = Bishop.new('white')
        expect(bishop.directions).to eql(
          [[1, 1],
           [1, -1],
           [-1, 1],
           [-1, -1]]
        )
      end
    end
  end

end

