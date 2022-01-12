# frozen_string_literal: true

require 'spec_helper'
require 'domain/board'
require 'domain/player'

describe Board do
  let(:subject) { described_class.new }

  it 'has 8x8 size' do
    expect(subject.positions).to match_array(Array.new(8) { Array.new(8, anything) })
  end

  describe 'initial state' do
    describe 'white side' do
      it 'has 8 pawns in correct position' do
        white_pawns_row = subject.positions[1]

        white_pawns_row.each do |position|
          expect(position.piece).to be_instance_of(Pawn)
          expect(position.piece.color).to be('white')
        end
      end

      it 'has 2 rooks' do
        white_rooks_positions = [subject.positions[0][0], subject.positions[0][7]]

        white_rooks_positions.each do |position|
          expect(position.piece).to be_instance_of(Rook)
          expect(position.piece.color).to be('white')
        end
      end

      it 'has 2 knights' do
        white_knights_position = [subject.positions[0][1], subject.positions[0][6]]

        white_knights_position.each do |position|
          expect(position.piece).to be_instance_of(Knight)
          expect(position.piece.color).to be('white')
        end
      end

      it 'has 2 bishops' do
        white_bishops_position = [subject.positions[0][2], subject.positions[0][5]]

        white_bishops_position.each do |position|
          expect(position.piece).to be_instance_of(Bishop)
          expect(position.piece.color).to be('white')
        end
      end

      it 'has 1 queen' do
        white_queen_position = subject.positions[0][3]

        expect(white_queen_position.piece).to be_instance_of(Queen)
        expect(white_queen_position.piece.color).to be('white')
      end

      it 'has 1 king' do
        white_king_position = subject.positions[0][4]

        expect(white_king_position.piece).to be_instance_of(King)
        expect(white_king_position.piece.color).to be('white')
      end
    end

    describe 'black side' do
      it 'has 8 pawns' do
        black_pawns_row = subject.positions[6]

        black_pawns_row.each do |position|
          expect(position.piece).to be_instance_of(Pawn)
          expect(position.piece.color).to be('black')
        end
      end

      it 'has 2 rooks' do
        black_rooks_positions = [subject.positions[7][0], subject.positions[7][7]]

        black_rooks_positions.each do |position|
          expect(position.piece).to be_instance_of(Rook)
          expect(position.piece.color).to be('black')
        end
      end

      it 'has 2 knights' do
        black_knights_positions = [subject.positions[7][1], subject.positions[7][6]]

        black_knights_positions.each do |position|
          expect(position.piece).to be_instance_of(Knight)
          expect(position.piece.color).to be('black')
        end
      end

      it 'has 2 bishops' do
        black_bishops_positions = [subject.positions[7][2], subject.positions[7][5]]

        black_bishops_positions.each do |position|
          expect(position.piece).to be_instance_of(Bishop)
          expect(position.piece.color).to be('black')
        end
      end

      it 'has 1 queen' do
        black_queen_position = subject.positions[7][3]

        expect(black_queen_position.piece).to be_instance_of(Queen)
        expect(black_queen_position.piece.color).to be('black')
      end

      it 'has 1 king' do
        black_king_position = subject.positions[7][4]

        expect(black_king_position.piece).to be_instance_of(King)
        expect(black_king_position.piece.color).to be('black')
      end
    end
  end

  describe '.position_state' do
    it 'returns nil if empty space' do
      expect(subject.position_state(4, 4)).to be(nil)
    end

    it 'returns black if contains black piece' do
      expect(subject.position_state(7, 0)).to be('black')
    end

    it 'returns white if contains white piece' do
      expect(subject.position_state(0, 0)).to be('white')
    end
  end
end
