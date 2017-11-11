require_relative "Colour"
require_relative "MoveOutcome"
class PlayerController
   def initialize(model, view)
      @subject = nil
      @model = model
      @view = view
   end
   def take_turn()
    @view.display_board(@model)
    sel_loc = nil
    selectResult = nil
    dest_loc = nil
    selectCapture = nil
    selectMove = nil
        
    while((selectCapture != MoveOutcome::Valid_capture && selectCapture != MoveOutcome::Win) && 
        selectMove != MoveOutcome::Valid_move) do
                
        sel_loc = nil
        selectResult = nil
        dest_loc = nil
        selectCapture = nil
        selectMove = nil
    
        while selectResult != MoveOutcome::Valid_selection do
            puts "Select stone"
            sel_loc = @view.prompt_location
            selectResult = @model.select_stone(sel_loc[0], sel_loc[1])
        end

        puts "Enter destination space"
        dest_loc = @view.prompt_location
        selectCapture = @model.capture_stone(dest_loc[0], dest_loc[1])
        selectMove = @model.move_stone(dest_loc[0], dest_loc[1])
    end
    if selectCapture == MoveOutcome::Valid_capture
        return selectCapture
    elsif selectMove == MoveOutcome::Valid_move
        return selectMove
    else
        return MoveOutcome::Invalid_move
    end
   end
end