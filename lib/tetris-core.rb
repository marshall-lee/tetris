
module Tetris
  class Cell < Struct.new(:x, :y); end

  class Block
    attr_reader :width, :height, :size
    attr_accessor :scene_x, :scene_y

    def initialize(cells: cells, scene_x: 0, scene_y: 0)
      @scene_x = scene_x 
      @scene_y = scene_y
      @cells = cells.map! { |obj| obj.is_a?(Hash) ? Cell.new(obj[:x], obj[:y]) : obj }
      xs = @cells.map(&:x)
      ys = @cells.map(&:y)
      min_x, max_x, min_y, max_y = xs.min, xs.max, ys.min, ys.max
      width  = max_x - min_x + 1
      height = max_y - min_y + 1
      @size = [width, height].max
    end

    # TODO: optimize
    def rotate(n = 1)
      n %= 4
      if n == 0
        self
      else
        cells = @cells.map do |cell|
          Cell.new(cell.y, @size - cell.x - 1)
        end
        self.class.new(
                    cells: cells,
                    scene_x: scene_x,
                    scene_y: scene_y)
                  .rotate(n-1)
      end
    end

    def rotate!(n = 1)
      @cells = self.rotate(n).cells
      self
    end

    def mirror
      cells = @cells.map do |cell|
        Cell.new(cell.x, @size - cell.y - 1)
      end
      self.class.new(cells: cells, scene_x: scene_x, scene_y: scene_y)
    end

    def mirror!
      @cells = self.mirror.cells
      self
    end

    def to_s
      ary = (1..@size).map { '.' * @size }
      @cells.each do |cell|
        ary[cell.x][cell.y] = '#'
      end
      ary.join "\n"
    end

    protected
      attr_reader :cells
  end


  class Scene
    attr_reader :width, :height

    def initialize(options)
      @width = options[:width] || 20
      @height = options[:height] || 10
      @cells = Hash.new
    end

    def to_s
      ary = (1..@height).map { '.' * @width }
      @cells.each_value do |cell|
        ary[cell.x][cell.y] = '#'
      end
      block_s = @active_block.to_s.split("\n")
      (0...@active_block.size).each do |x|
        (0...@active_block.size).each do |y|
          ary[@active_block.scene_x + x][@active_block.scene_y + y] = block_s[x][y]
        end
      end
      ary.join "\n"
    end
  end
end

require "tetris-blocks"
