# frozen_string_literal: true

require 'spec_helper'
require 'chess'

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
      black_player_double = instance_double(Player)

      mock_input

      expect(Player).to receive(:new).and_return(white_player_double)
      expect(Player).to receive(:new).and_return(black_player_double)
      expect(white_player_double).to receive(:move).and_return([Position.new(2, 5), Position.new(3, 5)])
      expect(Chess).to receive(:finish_condition?).and_return(true)

      subject.play
    end

    describe 'finish condition'
  end
end

def mock_input
  gets = double
  chomp = double
  allow(STDIN).to receive(:gets).and_return(gets)
  allow(gets).to receive(:chomp).and_return(chomp)
  allow(chomp).to receive(:downcase).and_return(anything)
end
