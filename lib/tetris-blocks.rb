
module Tetris
  class Block
    def self.create(name, **args)
      case name
      when :i then
        new(cells: [ {x: 1, y: 0},
                     {x: 1, y: 1},
                     {x: 1, y: 2},
                     {x: 1, y: 3} ], **args)
      when :o then
        new(cells: [ {x: 0, y: 0},
                     {x: 1, y: 0},
                     {x: 0, y: 1},
                     {x: 1, y: 1} ], **args)
      when :t then
        new(cells: [ {x: 0, y: 0},
                     {x: 0, y: 1},
                     {x: 0, y: 2},
                     {x: 1, y: 1} ], **args)
      when :j then
        new(cells: [ {x: 0, y: 0},
                     {x: 0, y: 1},
                     {x: 0, y: 2},
                     {x: 1, y: 2} ], **args)
      when :l then
        create(:j).mirror!
      when :s then
        new(cells: [ {x: 0, y: 1},
                     {x: 0, y: 2},
                     {x: 1, y: 0},
                     {x: 1, y: 1} ], **args)
      when :z then
        create(:s).mirror!
      end
    end
  end
end
