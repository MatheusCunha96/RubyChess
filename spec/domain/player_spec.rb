# frozen_string_literal: true

require 'spec_helper'
require 'domain/player'

describe Player do
  let(:subject) { Player.new('John') }

  it 'has a name' do
    expect(subject.name).to eql('John')
  end

  describe '.move' do
    it 'transform move from human form to position' do
      move_input_mock('e2 to e3')
      move = subject.move

      expect(move[0][0]).to eql(1)
      expect(move[0][1]).to eql(4)
      expect(move[1][0]).to eql(2)
      expect(move[1][1]).to eql(4)
    end
  end
end

def move_input_mock(move)
  gets = double
  allow(STDIN).to receive(:gets).and_return(gets)
  allow(gets).to receive(:chomp).and_return(move)
end
