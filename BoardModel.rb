require_relative "MoveOutcome"
require_relative "Colour"
require_relative "Stone"
require_relative "RuleBook"

class BoardModel
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
        return @stones.find{|stone| stone.row == row && stone.column == column}
    end
    
    def select_stone(row, column)
        if( (@select_stone = get_stone(row, column)) == nil ||
            @rules.validate_selection(row, column, @select_stone.colour) ==
            MoveOutcome::Invalid_selection)
            
            return MoveOutcome::Invalid_selection
        end
        return MoveOutcome::Valid_selection
    end
    
    def move_stone(row, column)
        if(@select_stone == nil ||
            @rules.validate_move(@select_stone.row, @select_stone.column,
                row, column) == MoveOutcome::Invalid_move)
            return MoveOutcome::Invalid_move
        end
            
        #update_list  
        for stone in @stones
            if(stone.row == @select_stone.row && stone.column == @select_stone.column)
                stone.move(row, column)
            end
        end    
        @select_stone = nil
        return MoveOutcome::Valid_move
    end
    
    def capture_stone(row, column)
        if(get_stone(row, column) != nil ||
            @rules.validate_capture(@select_stone.row, @select_stone.column, 
                row, column, @select_stone.colour) == MoveOutcome::Invalid_capture)
            return MoveOutcome::Invalid_capture    
        end
        
        #by default is 1, so that a default increment of 0 never reaches it
        y_bound = 10
        x_bound = 10
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
        y_values = Array.new
        i = x = @select_stone.column + (x_incr * 2)
        y = @select_stone.row + (y_incr * 2)
        
        until (x == x_bound + x_incr ||
            y == y_bound + y_incr || i == 8)
            
            x_values.push(x)
            x = x + x_incr
            y_values.push(y)
            y = y + y_incr
            
            next_stone = get_stone(y, x)
            if(next_stone != nil && next_stone.colour == @select_stone.colour)
                break
            end
            i = i + 1
        end

        total_coord_pairs = (x_values.length < y_values.length) ?
            x_values.length : y_values.length
         
        for j in 0..total_coord_pairs-1
            @stones.delete_if{|stone| stone.row == y_values[j] &&
                stone.column == x_values[j] && 
                stone.colour != @select_stone.colour}
        end   
    
        for stone in @stones
            if(stone.row == @select_stone.row && stone.column == @select_stone.column)
                stone.move(row, column)
            end
        end    
            
        @select_stone = nil
        
        stones_p1 = 0 
        stones_p2 = 0
        
        for stone in @stones
            (stone.colour == Colour::White) ? stones_p1 +=1 : stones_p2 +=1
        end
        
        return (stones_p1 == 0 || stones_p2 == 0) ? MoveOutcome::Win :
            MoveOutcome::Valid_capture
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
    end
end

class FanronaBoardModel < BoardModel
end

#new_obj = FanaronaBoardModel.new(5,9)

#puts new_obj.select_stone(1,4).to_s
#for stone in new_obj.stones
#    if(stone)
#        puts "colour:" + stone.colour.to_s + " row: " + stone.row.to_s + " col: " + stone.column.to_s
#    end
#end 

#puts new_obj.capture_stone(2,4).to_s

#for stone in new_obj.stones
#    if(stone)
#        puts "colour:" + stone.colour.to_s + " row: " + stone.row.to_s + " col: " + stone.column.to_s   
#    end
#end 