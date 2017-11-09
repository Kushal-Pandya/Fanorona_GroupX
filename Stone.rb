require_relative "Colour"
require_relative "Observer"
class Stone
   attr_accessor :colour, :row, :column
   def initialize(colour, row, column)
      @colour = colour
      @row = row
      @column = column
      @observer = Observer.new(nil)
   end
   def move(row, column)
      @row = row
      @column = column
   end
end