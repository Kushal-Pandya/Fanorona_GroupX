require_relative "Move_outcome"
require_relative "Colour"
require_relative "Stone"

#Checks if a value should be a white or black column in board (should only be 
#used for the middle row)
#
#If it belongs to white or black, returns that colour,
#else returns nil.
def which_colour?(white_columns, black_columns, value)
    if(white_columns.include?(value))
        return Colour::White
    else 
        return (black_columns.include?(value)) ? Colour::Black : nil
    end
end
class BoardModel
    #will make a board of any size, but has to deal with boards of size, 3x3,
    #5x5 or 5x9 (5 rows, 9 columns).
    def initialize(rows, columns)
        @stones = Array.new
        @rows = rows
        @columns = columns
        @rules = nil
        @subject = nil
        @select_stone = nil
        
        middle = (@rows / 2) - 1
        
        for i in 0..middle do
            for j in 0..@columns-1 do
                @stones.push( Stone.new(Colour::Black, i, j, nil))
            end
        end

        if(@columns == 3)
            #push three stones into stones array
            @stones.push( Stone.new(Colour::White, 1, 0, nil))
            @stones.push( Stone.new(nil, 1, 1, nil)) 
            @stones.push( Stone.new(Colour::Black, 1, 2, nil))
        elsif(@columns == 5)
            for j in 0..@columns-1 do
                @stones.push( Stone.new( which_colour?([1, 4], [0, 3], j), 
                    middle+1, j, nil))           
            end
        elsif(@columns == 9)
            for j in 0..@columns-1 do
                @stones.push( 
                    Stone.new( which_colour?([1, 3, 6, 8], [0, 2, 5, 7], j), 
                    middle+1, j, nil))
            end
        end    
        for i in middle + 2..@rows-1
            for j in 0..@columns-1
                @stones.push( Stone.new(Colour::White, i, j, nil))
            end
        end
        
        #Some code to test if the stones are set properly
        #for stone in @stones
            #puts "Colour:" + stone.colour.to_s + " Row: " + stone.row.to_s +
            #" Column: " + stone.column.to_s + "\n\n"
        #end
    end
    def get_stone(row, column)
        for stone in @stones
            if(stone.row == row && stone.column == column)
                return stone
            end
        end
        return nil
    end
    def select_stone(row, column)
        @select_stone = get_stone(row, column)
    end
    def move_stone(row, column)
    end
    def capture_stone(row, column)
    end
end

class FanoronaBoardModel < BoardModel
    def reset_stones()
    end
end

#new_obj = BoardModel.new(5,9)
#thing = new_obj.get_stone(1, 4)

#puts thing.colour.to_s + " " + thing.row.to_s + " " + thing.column.to_s