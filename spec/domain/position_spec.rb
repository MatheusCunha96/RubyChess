# frozen_string_literal: true

require 'spec_helper'
require 'domain/position'
require 'domain/pieces/pawn'

describe Position do
  let(:position) { Position.new(2, 3) }

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
      position = Position.new(1, 1)
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

  describe '#being_attacked?' do
    let(:position) { Position.new(1, 1) }

    it 'return true if position being attack by white' do
      position.states[:attacked_by_white] = true

      expect(position.being_attacked_by_white?).to be_truthy
    end

    it 'return true if position being attack by black' do
      position.states[:attacked_by_black] = true

      expect(position.being_attacked_by_black?).to be_truthy
    end

    it 'return false if position not being attack by any piece' do
      expect(position.being_attacked_by_black?).to be_falsey
    end
  end

  describe '#being_attacked_by_white?' do
    let(:position) { Position.new(1, 1) }

    it 'return true if position being attacked by white' do
      position.states[:attacked_by_white] = true

      expect(position.being_attacked_by_white?).to be_truthy
    end

    it 'return false if position not being attacked by white' do
      position.states[:attacked_by_white] = false

      expect(position.being_attacked_by_white?).to be_falsey
    end
  end

  describe '#being_attacked_by_black?' do
    let(:position) { Position.new(1, 1) }

    it 'return true if position being attacked by black' do
      position.states[:attacked_by_black] = true

      expect(position.being_attacked_by_black?).to be_truthy
    end

    it 'return false if position not being attacked by black' do
      position.states[:attacked_by_black] = false

      expect(position.being_attacked_by_black?).to be_falsey
    end
  end

  describe '#being_attacked_by?' do
    describe 'white' do
      let(:position) { Position.new(1, 1) }

      it 'return true if position being attacked by a white piece' do
        position.states[:attacked_by_white] = true

        expect(position.being_attacked_by?('white')).to be_truthy
      end

      it 'return false if position not being attacked by a white piece' do
        position.states[:attacked_by_white] = false

        expect(position.being_attacked_by?('white')).to be_falsey
      end
    end

    describe 'black' do
      let(:position) { Position.new(1, 1) }

      it 'return true if position being attacked by a black piece' do
        position.states[:attacked_by_black] = true

        expect(position.being_attacked_by?('black')).to be_truthy
      end

      it 'return false if position not being attacked by a black piece' do
        position.states[:attacked_by_black] = false

        expect(position.being_attacked_by?('black')).to be_falsey
      end
    end
  end

  describe '#free?' do
    let(:position) { Position.new(1, 1) }

    it 'return true if position without any piece' do
      position.states[:free] = true

      expect(position.free?).to be_truthy
    end

    it 'return false if position have any piece' do
      position.states[:free] = false

      expect(position.free?).to be_falsey
    end
  end

  describe '#occupied_by?' do
    describe 'white' do
      let(:position) { Position.new(1, 1) }

      it 'return true if position have a white piece' do
        position.states[:occupied_by_white] = true

        expect(position.occupied_by?('white')).to be_truthy
      end

      it 'return false if position dont have a white piece' do
        position.states[:occupied_by_white] = false

        expect(position.occupied_by?('white')).to be_falsey
      end
    end

    describe 'black' do
      let(:position) { Position.new(1, 1) }

      it 'return true if position have a black piece' do
        position.states[:occupied_by_black] = true

        expect(position.occupied_by?('black')).to be_truthy
      end

      it 'return false if position dont have a black piece' do
        position.states[:occupied_by_black] = false

        expect(position.occupied_by?('black')).to be_falsey
      end
    end
  end
end
