# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/queen'
require 'domain/position'
require 'domain/board'

describe Queen do
  let(:board) { Board.new }

  after { reset_board(board) }

  describe '.new' do
    let(:color) { 'white' }
    let(:queen) { Queen.new(color) }

    it 'current position must initialize nil' do
      expect(queen.current_position).to be_nil
    end

    it 'must have color' do
      expect(queen.color).to eql(color)
    end

    describe 'image' do
      it 'should be white if white queen' do
        queen = Queen.new('white')
        expect(queen.image).to eql('♛')
      end

      it 'should be black if black queen' do
        queen = Queen.new('black')
        expect(queen.image).to eql('♕')
      end
    end

    describe 'directions' do
      it 'must have correct possibles move' do
        queen = Queen.new('white')
        expect(queen.directions).to eql(
          [[0, 1],
           [0, -1],
           [1, 0],
           [-1, 0],
           [1, 1],
           [1, -1],
           [-1, 1],
           [-1, -1]]
        )
      end
    end
  end

end
