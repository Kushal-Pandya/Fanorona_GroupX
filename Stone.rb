require_relative "Colour"
class Stone
   def initialize(colour, row, column, observer)
      @colour = colour
      @row = row
      @column = column
      @observer = observer
   end
   def move(row, column)
   end
end