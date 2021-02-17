# frozen_string_literal: true

require 'spec_helper'
require 'player'

describe Player do
  let(:subject) { Player.new('John') }

  it 'has a name' do
    expect(subject.name).to eql('John')
  end

  describe '.move' do
    it '' do
      move_input_mock('e2 to e3')
      move = subject.move

      expect(move[0].row).to eql(2)
      expect(move[0].col).to eql(5)
      expect(move[1].row).to eql(3)
      expect(move[1].col).to eql(5)
    end
  end
end

def move_input_mock(move)
  gets = double
  allow(STDIN).to receive(:gets).and_return(gets)
  allow(gets).to receive(:chomp).and_return(move)
end
