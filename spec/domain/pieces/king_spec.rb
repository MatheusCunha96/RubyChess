# frozen_string_literal: true

require 'spec_helper'
require 'domain/pieces/king'
# require 'domain/position'
require 'domain/board'

describe King do
  let(:board) { Board.new }

  after { reset_board(board) }

  describe '.new' do
    let(:color) { 'white' }
    let(:king) { King.new(color) }

    it 'current position must initialize nil' do
      expect(king.current_position).to be_nil
    end

    it 'must have color' do
      expect(king.color).to eql(color)
    end

    describe 'move_set' do
      it 'must have correct possibles move' do
        king = Queen.new('white')
        expect(king.move_set).to eql(
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

  describe '#find_moves' do
    context ''
  end
end
