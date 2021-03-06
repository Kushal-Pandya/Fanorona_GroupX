require_relative "MoveOutcome"


#
# RuleBook class validates selections, moves and captures
# => Basically acts like the Fanorona rulebook
# Needed to add 3 additional methods from design
#
class RuleBook
    def initialize(stones)
        @stones = stones
    end

    def validate_selection(row, column, userColour)

        #check if user has selected its own stone or empty space
        stoneSelected = get_stone(row, column)
        if (stoneSelected == nil || stoneSelected.colour != userColour)
            return MoveOutcome::Invalid_selection
        end
        return MoveOutcome::Valid_selection
    end

    def validate_move(srcRow, srcColumn, destRow, destColumn)

        #check first if user is not moving to occupied space
        stoneSelected =   get_stone(destRow, destColumn)
        if (stoneSelected != nil)
            return MoveOutcome::Invalid_move
        end

        # Next check if move is a valid adjacent move
        if (!  is_adjacent?(srcRow, srcColumn, destRow, destColumn))
            return MoveOutcome::Invalid_move
        end

        return MoveOutcome::Valid_move
    end

    # This also checks if the move to capture was also valid
    def validate_capture(srcRow, srcColumn, destRow, destColumn, userColour)

        # if columns are the same then stone has moved left or right
        # this is for weak intersection
        if (srcColumn == destColumn)
            if (srcRow+1 == destRow || srcRow-1 == destRow)

                # checking towards stone
                if (get_stone(destRow+1, destColumn) != nil && get_stone(destRow+1, destColumn).colour != userColour)
                    return MoveOutcome::Valid_capture
                # checking away stone
                elsif (get_stone(destRow-1, destColumn) != nil && get_stone(destRow-1, destColumn).colour != userColour)
                    return MoveOutcome::Valid_capture
                end
            end
        elsif (srcRow == destRow) #moved up or down
            if (srcColumn+1 == destColumn || srcColumn-1 == destColumn)
                # checking towards stone
                if (get_stone(destRow, destColumn+1) != nil && get_stone(destRow, destColumn+1).colour != userColour)
                    return MoveOutcome::Valid_capture
                # checking away stone
                elsif (get_stone(destRow, destColumn-1) != nil && get_stone(destRow, destColumn-1).colour != userColour)
                    return MoveOutcome::Valid_capture
                end
            end
        end

        # If its a strong intersection, need to check diagonally too
        if (  is_strong_intersection?(srcRow, srcColumn))

            # check if stone has moved top-right
            if (srcRow+1 == destRow && srcColumn+1 == destColumn)
                #check toward stone
                if (get_stone(destRow+1, destColumn+1) != nil && get_stone(destRow+1, destColumn+1).colour != userColour)
                    return MoveOutcome::Valid_capture
                # checking away stone
                elsif (get_stone(srcRow-1, srcColumn-1) != nil && get_stone(srcRow-1, srcColumn-1).colour != userColour)
                    return MoveOutcome::Valid_capture
                end
            # check if stone has moved bottom-right
            elsif (srcRow+1 == destRow && srcColumn-1 == destColumn)
                #check toward stone
                if (get_stone(destRow+1, destColumn-1) != nil && get_stone(destRow+1, destColumn-1).colour != userColour)
                    return MoveOutcome::Valid_capture
                # checking away stone
                elsif (get_stone(srcRow-1, srcColumn+1) != nil && get_stone(srcRow-1, srcColumn+1).colour != userColour)
                    return MoveOutcome::Valid_capture
                end
            # check if stone has moved bottom-left
            elsif (srcRow-1 == destRow && srcColumn-1 == destColumn)
                #check toward stone
                if (get_stone(destRow-1, destColumn-1) != nil && get_stone(destRow-1, destColumn-1).colour != userColour)
                    return MoveOutcome::Valid_capture
                # checking away stone
                elsif (get_stone(srcRow+1, srcColumn+1) != nil && get_stone(srcRow+1, srcColumn+1).colour != userColour)
                    return MoveOutcome::Valid_capture
                end
            # check if stone has moved top-left
            elsif (srcRow-1 == destRow && srcColumn+1 == destColumn)
                #check toward stone
                if (get_stone(destRow-1, destColumn+1) != nil && get_stone(destRow-1, destColumn+1).colour != userColour)
                    return MoveOutcome::Valid_capture
                # checking away stone
                elsif (get_stone(srcRow+1, srcColumn-1) != nil && get_stone(srcRow+1, srcColumn-1).colour != userColour)
                    return MoveOutcome::Valid_capture
                end
            end

        end
        return MoveOutcome::Invalid_capture
    end

    # get_stone method copied verbatim from BoardModel class
    def get_stone(row, column)
        for stone in @stones
      
            if(stone.row == row && stone.column == column)
                return stone
            end
        end
        return nil
    end

    # check here that the move is valid, horizontally, vertically, or diagonally 
    # returns True if adjacent, false otherwise
    def   is_adjacent?(srcRow, srcColumn, destRow, destColumn)

        # if columns are the same then moved left or right
        if (srcColumn == destColumn)
            if (srcRow+1 == destRow || srcRow-1 == destRow)
                return true
            end
        elsif (srcRow == destRow) #moved up or down
            if (srcColumn+1 == destColumn || srcColumn-1 == destColumn)
                return true
            end
        end

        # If its a strong intersection, need to check diagonally too
        if (  is_strong_intersection?(srcRow, srcColumn))

            # Has moved diagonally top-right/bottom-right
            # thus, column should be top or bottom
            if (srcRow+1 == destRow)
                if (srcColumn+1 == destColumn || srcColumn-1 == destColumn)
                    return true
                else
                    return false
                end
            elsif (srcRow-1 == destRow)  # Has moved diagonally top-left/bottom-left
                if (srcColumn+1 == destColumn || srcColumn-1 == destColumn)
                    return true
                else
                    return false
                end
            else
                return false
            end
        else
            return false
        end
    end

    # Determine if intersection is strong or weak by checking parity
    def   is_strong_intersection?(row, column)
        return((row+column).even?)
    end
end


# Dont know if we need this??
class FanoronaRuleBook < RuleBook
end


