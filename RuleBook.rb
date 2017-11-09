require_relative "BoardView"
require_relative "MoveOutcome"

class RuleBook
    def initialize()
        @boardView = BoardView.new()
    end
    def validate_selection(row, column)
    end
    def validate_move(row, column)
    end
    def validate_capture(row, column)
    end
end



class FanoronaRuleBook < RuleBook
end