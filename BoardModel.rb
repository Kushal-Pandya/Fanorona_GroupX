require_relative "MoveOutcome"
require_relative "Colour"
require_relative "Stone"

class FanaronaBoardModel
    #Checks if a value should be a white or black column in board based on the 
    #array of columns that should be white. If it belongs to the array of white 
    #columns, returns white, otherwise returns the colour black.
    #Returns white or black
    def which_colour?(white_columns, value)
        return (white_columns.include?(value)) ? Colour::White : Colour::Black
    end
    #will make a board of any size, but has to deal with boards of size, 3x3,
    #5x5 or 5x9 (5 rows, 9 columns).
    def initialize(rows, columns, ruleBook)
        @stones = Array.new
        @rows = rows
        @columns = columns
        @rules = ruleBook
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
    def delete_stone(row, column)
        for stone in @stones
            if(stone.row == row && stone.column == column)
                @stones.delete(stone)
            end
        end
    end
    def select_stone(row, column)
        #I need Rulebook to be working before this can be done
        #outcome = rules.validateSelection(row, column)
        #if(outcome == MoveOutcome::Valid_selection)
            @select_stone = get_stone(row, column)
        #elsif(outcome == MoveOutcome::Invalid_selection)
            #@select_stone = nil
        #return outcome
    end
    def move_stone(row, column)
        outcome = rules.validate_move(row, column)
        
        if(outcome == MoveOutcome::Valid_move)
            #move stone in array
            prev_row = @select_stone.row
            prev_column = @select_stone.column
            change_select_stone(row, column)
            #move stone that has been selected (due to pass by value)
            @select_stone.move(row, column)
            delete_stone(prev_row, prev_column)
        end
        return outcome
    end
    def capture_stone(row, column)
        outcome = rules.validate_capture(row, column)
        
        if(outcome == MoveOutcome::Valid_capture)
            for stone in @stones
                if(stone.row == row && stone.column == column)
                    @stones.delete(stone)
                end
            end
            prev_row = @select_stone.row
            prev_column = @select_stone.column
            @select_stone.move(row, column)
            delete_stone(prev_row, prev_column)
        end
        return outcome
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
                @stones.push( 
                    Stone.new( which_colour?([1, 4], j), middle+1, j))   
            end
        elsif(@columns == 9)
            [0, 1, 2, 3, 5, 6, 7, 8].each do |j|
                @stones.push(
                    Stone.new( which_colour?([1, 3, 6, 8], j), middle+1, j))
            end
        end    
        for i in middle + 2..@rows-1
            for j in 0..@columns-1
                @stones.push( Stone.new(Colour::White, i, j))
            end
        end
        #Some code to test if the stones are set properly
        for stone in @stones
            puts "Colour:" + stone.colour.to_s + " Row: " + stone.row.to_s +
            " Column: " + stone.column.to_s + "\n\n"
        end
    end
end

new_obj = FanaronaBoardModel.new(5,9, nil)
#thing = new_obj.get_stone(1, 4)

#puts thing.colour.to_s + " " + thing.row.to_s + " " + thing.column.to_s