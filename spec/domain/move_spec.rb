# frozen_string_literal: true

require 'spec_helper'
require 'domain/move'
require 'domain/board'
require 'domain/player'
require 'domain/pieces/piece'

describe Move do
  let(:board) { Board.new }

  after { reset_board(board) }

  describe '.execute' do
    let(:player) { Player.new('John', 'white') }
    let(:move) { [orig, dest] }

    context 'when position has piece' do
      let(:orig) { [1, 5] }
      let(:dest) { [2, 5] }

      before { board.positions[1][5].piece.find_moves(board) }

      it 'move piece from orig to dest' do
        described_class.execute(player, move, board)

        expect(board.positions[1][5].piece).to be_nil
        expect(board.positions[2][5].piece).to be_instance_of(Pawn)
      end

      it 'return true' do
        expect(described_class.execute(player, move, board)).to be_truthy
      end
    end

    context 'when position is empty' do
      let(:orig) { [2, 5] }
      let(:dest) { [1, 5] }

      before do
        allow(Messenger).to receive(:notify_empty_position)
      end

      it 'notify empty position' do
        described_class.execute(player, move, board)

        expect(Messenger).to have_received(:notify_empty_position)
      end

      it 'return false' do
        expect(described_class.execute(player, move, board)).to be_falsy
      end
    end

    context 'when not possible move' do
      let(:orig) { [1, 5] }
      let(:dest) { [5, 5] }

      before do
        allow(Messenger).to receive(:notify_not_possible_move)
      end

      it 'notify not possible move' do
        described_class.execute(player, move, board)

        expect(Messenger).to have_received(:notify_not_possible_move)
      end

      it 'return false' do
        expect(described_class.execute(player, move, board)).to be_falsy
      end
    end

    context 'when try to move opponent piece' do
      let(:orig) { [6, 5] }
      let(:dest) { [5, 5] }

      before do
        allow(Messenger).to receive(:notify_opponent_piece)
      end

      it 'notify opponent piece' do
        described_class.execute(player, move, board)

        expect(Messenger).to have_received(:notify_opponent_piece)
      end

      it 'return false' do
        expect(described_class.execute(player, move, board)).to be_falsy
      end
    end
  end
end
