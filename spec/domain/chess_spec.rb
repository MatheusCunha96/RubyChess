# frozen_string_literal: true

require 'spec_helper'
require 'domain/chess'

describe Chess do
  let(:subject) { Chess.new }

  it 'has a board' do
    expect(subject.board).to be_instance_of(Board)
  end

  it 'turn start at zero' do
    expect(subject.turn).to eql(0)
  end

  it 'players start nil' do
    expect(subject.player_white).to eql(nil)
    expect(subject.player_black).to eql(nil)
  end

  it 'players initialization' do
    mock_input
    subject.send(:create_players)

    expect(subject.player_white).to be_instance_of(Player)
    expect(subject.player_black).to be_instance_of(Player)
  end

  describe '.play' do
    it 'simple move' do
      white_player_double = instance_double(Player)
      allow(white_player_double).to receive(:name).and_return('John')
      allow(white_player_double).to receive(:color).and_return('white')
      black_player_double = instance_double(Player)
      allow(black_player_double).to receive(:name).and_return('Josh')
      allow(black_player_double).to receive(:color).and_return('black')

      mock_input
      finish_game_after_move(2)

      expect(Player).to receive(:new).and_return(white_player_double)
      expect(Player).to receive(:new).and_return(black_player_double)
      expect(white_player_double).to receive(:move).and_return([[1, 4], [2, 4]])
      expect(black_player_double).to receive(:move).and_return([[6, 4], [5, 4]])

      subject.play

      expect(subject.board.positions[1][4].piece).to eql(nil)
      expect(subject.board.positions[2][4].piece).to be_instance_of(Pawn)
      expect(subject.board.positions[6][4].piece).to eql(nil)
      expect(subject.board.positions[5][4].piece).to be_instance_of(Pawn)
    end

    describe 'finish condition'
  end
end

def finish_game_after_move(move)
  expect_any_instance_of(Chess).to receive(:finish_condition?).exactly(move).and_return(false)
  expect_any_instance_of(Chess).to receive(:finish_condition?).and_return(true)
end

def mock_input
  gets = double
  chomp = double
  allow($stdin).to receive(:gets).and_return(gets)
  allow(gets).to receive(:chomp).and_return(chomp)
  allow(chomp).to receive(:downcase).and_return(anything)
end
