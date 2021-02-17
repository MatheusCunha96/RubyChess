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

  describe '.play' do
    it 'start players' do
      mock_input
      subject.play
      expect(subject.player_white).to be_instance_of(Player)
      expect(subject.player_black).to be_instance_of(Player)
    end

    describe 'finish condition'
  end
end

def mock_input
  gets = double
  allow(STDIN).to receive(:gets).and_return(gets)
  allow(gets).to receive(:chomp).and_return(anything)
end
