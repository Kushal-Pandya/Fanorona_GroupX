require_relative "Move_outcome"
require_relative "Colour"
require_relative "Stone"
class BoardModel
    def initialize(rows, columns)
        @stones = Array.new
        @rows = rows
        @columns = columns
        @rules = nil
        @subject = nil
        @select_stone = nil
        
        middle = ((@rows.to_f / 2) - 1).floor
        #board sizes: 3X3, 5X9, 5X5
        
        #TODO: initialize every stone into list of 'stones' part of BoardModel
        for i in 0..middle do
            for j in 0..@columns-1 do
                puts "color:" + Colour::White.to_s + " Y:" + i.to_s + " X:" + j.to_s 
                @stones << Stone.new(Colour::White, i, j, nil)
            end
        end
        middle = middle + 1
        puts ""
        if(@columns == 3)
            @stones << Stone.new(Colour::Black, 1, 0, nil)
            @stones << Stone.new(nil, 1, 1, nil)
            @stones << Stone.new(Colour::White, 1, 2, nil)
            #puts "color:" + Colour::Black.to_s + " Y:" + 1.to_s + " X:" + 0.to_s
            #puts "color:" + nil.to_s + " Y:" + 1.to_s + " X:" + 1.to_s
            #puts "color:" + Colour::White.to_s + " Y:" + 1.to_s + " X:" + 2.to_s
        elsif(@columns == 5)
            for j in 0..@columns do
                stone_colour = nil
                
                if (j == 0 || j == 3) 
                    stone_colour = Colour_white
                elsif(j == 1 || j == 4)
                    stone_colour = Colour::Black
                end   
                @stones << Stone.new(stone_colour, middle, j, nil)
                #puts "color:" + stone_colour.to_s + " Y:" + middle.to_s + " X:" + j.to_s
            end
        elsif(@columns == 9)
            for j in 0..@columns-1 do
                stone_colour = nil;
                
                if(j == 0 || j == 2 || j == 5 || j == 7) 
                    stone_colour = Colour::White 
                elsif (j == 1 || j == 3 || j == 6 || j == 8) 
                    stone_colour = Colour::Black 
                end
                    
                @stones << Stone.new(stone_colour, middle, j, nil)
                puts "color:" + Colour::Black.to_s + " Y:" + middle.to_s + " X:" + j.to_s
            end
        end    
        puts ""
        for i in middle + 1..@rows-1
            for j in 0..@columns-1
                @stones << Stone.new(Colour::Black, i, j, nil)
                puts "color:" + Colour::Black.to_s + " Y:" + i.to_s + " X:" + j.to_s
            end
        end
    end
    def get_stone(row, column)
    end
    def select_stone(row, column)
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

#puts ( ((5.to_f/2) - 1).ceil).to_s

new_obj = BoardModel.new(5,9)