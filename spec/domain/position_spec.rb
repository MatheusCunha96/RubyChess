# frozen_string_literal: true

require 'spec_helper'
require 'domain/position'
require 'domain/pieces/pawn'

describe Position do
  let(:position) { Position.new(2,3) }

  describe '#new' do
    it 'has row, column and empty piece slot' do
      expect(position.row).to eql(2)
      expect(position.col).to eql(3)
      expect(position.piece).to be_nil
    end
  end

  describe '#piece=' do
    it 'add piece to position and update piece current position' do
      piece = Pawn.new('white')

      position.piece = piece

      expect(position.piece).to be_instance_of(Pawn)
      expect(piece.current_position).to match_array([2, 3])
    end
  end

  describe '#remove_piece' do
    it 'set position piece to nil' do
      position = Position.new(1,1)
      piece = Pawn.new('white')
      position.piece = piece

      position.remove_piece

      expect(position.piece).to be_nil
    end
  end

  describe '#as_array' do
    it 'returns position row and column in array style' do
      expect(position.as_array).to match_array([2, 3])
    end
  end

end
