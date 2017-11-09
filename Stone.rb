require_relative "Colour"
class Stone
   attr_accessor :colour, :row, :column
   def initialize(colour, row, column, observer)
      @colour = colour
      @row = row
      @column = column
      @observer = observer
   end
   def move(row, column)
      @row = row
      @column = column
   end
end