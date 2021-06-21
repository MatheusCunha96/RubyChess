# frozen_string_literal: true

require 'spec_helper'
require 'domain/position'

describe Position do
  let(:position) { Position.new(2,3) }
  describe '#new' do
    it 'has row, column and empty piece slot' do
      expect(position.row).to eql(2)
      expect(position.col).to eql(3)
      expect(position.piece).to be_nil
    end
  end

  describe '#to_a' do
    it 'returns position row and column in array style' do
      expect(position.to_a).to eql([2,3])
    end
  end

end
