require_relative "MoveOutcome"
require_relative "Colour"
require_relative "Stone"
require_relative "RuleBook"

class FanaronaBoardModel
    attr_accessor :rows, :columns, :stones
    #will make a board of any size, but has to deal with boards of size, 3x3,
    #5x5 or 5x9 (5 rows, 9 columns).
    def initialize(rows, columns)
        @stones = Array.new
        @rows = rows
        @columns = columns
        @rules = RuleBook.new(@stones)
        @subject = nil
        @select_stone = nil
        reset_stones()
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
        if(@select_stone == nil)
            return MoveOutcome::Invalid_selection
        end
            
        if(@rules.validate_selection(row, column, @select_stone.colour) ==
            MoveOutcome::Valid_selection)
            return MoveOutcome::Valid_selection
        else
            return MoveOutcome::Invalid_selection
        end
    end
    
    def move_stone(row, column)
        if(@rules.validate_move(@select_stone.row, @select_stone.column,
                row, column) == MoveOutcome::Valid_move)
            
            #update_list  
            for stone in @stones
                if(stone.row == @select_stone.row && stone.column == @select_stone.column)
                    stone.move(row, column)
                end
            end    
            @select_stone = nil
            return MoveOutcome::Valid_move
        end
        return MoveOutcome::Invalid_move
    end
    
    def capture_stone(row, column)
        if(@rules.validate_capture(@select_stone.row, @select_stone.column, 
                row, column, @select_stone.colour) == MoveOutcome::Invalid_capture)
            return MoveOutcome::Invalid_capture    
        end
        
        #by default is 1, so that a default increment of 0 never reaches it
        y_bound = 1
        x_bound = 1
        y_diff = @select_stone.row - row
        x_diff = @select_stone.column - column
        y_incr = 0
        x_incr = 0
            
        #do not add else's here, default values are above
        if(y_diff < 0)
            y_incr = 1
            y_bound = @rows
        elsif(y_diff > 0)
            y_incr = -1
            y_bound = 0
        end
        
        if(x_diff < 0)
            x_incr = 1
            x_bound = @columns
        elsif(x_diff > 0)
            x_incr = -1
            x_bound = 0
        end
        
        #two increments ahead, so that the first space it checks is the next space
        #after the move. Very important
        #also, if x or y increment are 0, makes an array with 8 of the same number
        x_values = Array.new
        i = x = @select_stone.column + (x_incr * 2)
        until (x == x_bound + x_incr || i == 8)
            x_values.push(x)
            x = x + x_incr
            i = i + 1
        end 

        y_values = Array.new
        j = y = @select_stone.row + (y_incr * 2)
        until (j == y_bound + y_incr || j == 8)
            y_values.push(y)
            y = y + y_incr
            j = j + 1
        end

        for i in 0..x_values.length
            #very powerful ruby function
            @stones.delete_if{|stone| stone.row == y_values[i] && 
                stone.column == x_values[i] &&
                stone.colour != @select_stone.colour
            }
        end
            
        for stone in @stones
            if(stone.row == @select_stone.row && stone.column == @select_stone.column)
                stone.move(row, column)
            end
        end    
            
        @select_stone = nil
        return MoveOutcome::Valid_capture
    end
    
    def reset_stones()
        middle = (@rows / 2) - 1
        
        for i in 0..middle do
            for j in 0..@columns-1 do
                @stones.push( Stone.new(Colour::Black, i, j))
            end
        end

        #whichever space is in the center does not receive a stone,
        #if columns is 3, it's at 1, 5, it is 2, and 9 it is 4.
        if(@columns == 3)
            @stones.push( Stone.new(Colour::White, 1, 0))
            @stones.push( Stone.new(Colour::Black, 1, 2))
        elsif(@columns == 5)
            [0, 1, 3, 4].each do |j|
                #check array of possible white spaces for the value
                colour = ([1, 4].include?(j)) ? Colour::White : Colour::Black
                
                @stones.push( Stone.new( colour, middle+1, j))   
            end
        elsif(@columns == 9)
            [0, 1, 2, 3, 5, 6, 7, 8].each do |j|
                #do the same as for columns == 5, except with a different array
                colour = ([1, 3, 6, 8].include?(j)) ? 
                    Colour::White : Colour::Black
                    
                @stones.push( Stone.new(colour, middle+1, j))
            end
        end    
        for i in middle + 2..@rows-1
            for j in 0..@columns-1
                @stones.push( Stone.new(Colour::White, i, j))
            end
        end
        #Some code to test if the stones are set properly
        #for stone in @stones
        #   puts "Colour:" + stone.colour.to_s + " Row: " + stone.row.to_s +
        #    " Column: " + stone.column.to_s + "\n\n"
        #end
    end
end

#new_obj = FanaronaBoardModel.new(5,9)

#puts new_obj.select_stone(1,4).to_s
#for stone in new_obj.stones
#    if(stone)
        #puts "colour:" + stone.colour.to_s + " row: " + stone.row.to_s + " col: " + stone.column.to_s
#    end
#end 

#puts new_obj.capture_stone(2,4).to_s

#for stone in new_obj.stones
#    if(stone)
#        puts "colour:" + stone.colour.to_s + " row: " + stone.row.to_s + " col: " + stone.column.to_s   
#    end
#end 