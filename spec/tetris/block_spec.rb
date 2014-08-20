
require 'spec_helper'
require 'tetris-core'

RSpec::Matchers.define :contain_points do |*hashes_or_points|
  points = hashes_or_points.map do |obj|
    obj.is_a?(Hash) ? Tetris::Point.new(obj[:x], obj[:y]) : obj
  end
  match do |block|
    block.points.length == points.length &&
      points.all? { |p| block.points.include? p }
  end
end

describe Tetris::Block do
  subject { block.to_s.split("\n") }
  let(:block) { nil }

  describe "Straight Polyomino" do
    let(:block) { Tetris::Block.create :i }

    it { should eq(%w|....
                      ####
                      ....
                      ....|) }

    it "should rotate one time as expected" do
      block.rotate!
      should eq(%w|..#.
                   ..#.
                   ..#.
                   ..#.|)
    end

    it "should rotate two times as expected" do
      block.rotate! 2
      should eq(%w|....
                   ....
                   ####
                   ....|)
    end

    it "should rotate three times as expected" do
      block.rotate! 3
      should eq(%w|.#..
                   .#..
                   .#..
                   .#..|)
    end

    it "should move to initial after four rotates" do
      expect {
        block.rotate! 4
      }.to_not change{subject}
    end
  end

  describe "Square Polyomino" do
    let(:block) { Tetris::Block.create :o }

    it { should eq(%w|##
                      ##|) }

    it "is not rotatable" do
      expect {
        block.rotate!
      }.not_to change{subject}
    end
  end

  describe "T-Polyomino" do
    let(:block) { Tetris::Block.create :t }
    it { should eq(%w|###
                      .#.
                      ...|) }

    it "should rotate one time as expected" do
      block.rotate!
      should eq(%w|..#
                   .##
                   ..#|)
    end

    it "should rotate two times as expected" do
      block.rotate! 2
      should eq(%w|...
                   .#.
                   ###|)
    end

    it "should rotate three times as expected" do
      block.rotate! 3
      should eq(%w|#..
                   ##.
                   #..|)
    end

    it "should move to initial after four rotates" do
      expect {
        block.rotate! 4
      }.to_not change{subject}
    end
  end

  describe "J: a row of three blocks with one added below the right side" do
    let(:block) { Tetris::Block.create :j }

    it { should eq(%w|###
                      ..#
                      ...|) }

    it "should rotate one time as expected" do
      block.rotate!
      should eq(%w|..#
                   ..#
                   .##|)
    end

    it "should rotate two times as expected" do
      block.rotate! 2
      should eq(%w|...
                   #..
                   ###|)
    end

    it "should rotate three times as expected" do
      block.rotate! 3
      should eq(%w|##.
                   #..
                   #..|)
    end

    it "should move to initial after four rotates" do
      expect {
        block.rotate! 4
      }.to_not change{subject}
    end
  end

  describe "L: a row of three blocks with one added below the left side" do
    let(:block) { Tetris::Block.create :l }

    it { should eq(%w|###
                      #..
                      ...|) }

    it "should rotate one time as expected" do
      block.rotate!
      should eq(%w|.##
                   ..#
                   ..#|)
    end

    it "should rotate two times as expected" do
      block.rotate! 2
      should eq(%w|...
                   ..#
                   ###|)
    end

    it "should rotate three times as expected" do
      block.rotate! 3
      should eq(%w|#..
                   #..
                   ##.|)
    end

    it "should move to initial after four rotates" do
      expect {
        block.rotate! 4
      }.to_not change{subject}
    end
  end

  describe "S: two stacked horizontal dominoes with the top one offset to the right" do
    let(:block) { Tetris::Block.create :s }

    it { should eq(%w|.##
                      ##.
                      ...|) }

    it "should rotate one time as expected" do
      block.rotate!
      should eq(%w|.#.
                   .##
                   ..#|)
    end

    it "should rotate two times as expected" do
      block.rotate! 2
      should eq(%w|...
                   .##
                   ##.|)
    end

    it "should rotate three times as expected" do
      block.rotate! 3
      should eq(%w|#..
                   ##.
                   .#.|)
    end

    it "should move to initial after four rotates" do
      expect {
        block.rotate! 4
      }.to_not change{subject}
    end
  end

  describe "Z: two stacked horizontal dominoes with the top one offset to the left" do
    let(:block) { Tetris::Block.create :z }

    it { should eq(%w|##.
                      .##
                      ...|) }

    it "should rotate one time as expected" do
      block.rotate!
      should eq(%w|..#
                   .##
                   .#.|)
    end

    it "should rotate two times as expected" do
      block.rotate! 2
      should eq(%w|...
                   ##.
                   .##|)
    end

    it "should rotate three times as expected" do
      block.rotate! 3
      should eq(%w|.#.
                   ##.
                   #..|)
    end

    it "should move to initial after four rotates" do
      expect {
        block.rotate! 4
      }.to_not change{subject}
    end
  end
end 
