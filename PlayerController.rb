require_relative "Colour"
require_relative "MoveOutcome"
class PlayerController
   def initialize(model, view)
      @subject = nil
      @model = model
      @view = view
   end
   def take_turn()
    sel_loc = @view.prompt_location
    selectResult = @model.select_stone(sel_loc[0], sel_loc[1])
    
    while selectResult != MoveOutcome::Valid_selection do
        puts "select"
        sel_loc = @view.prompt_location
        selectResult = @model.select_stone(sel_loc[0], sel_loc[1])
    end

    dest_loc = @view.prompt_location
    selectCapture = @model.capture_stone(dest_loc[0], dest_loc[1])
    selectMove = @model.move_stone(dest_loc[0], dest_loc[1])
    while(selectCapture != MoveOutcome::Valid_capture && 
        selectMove != MoveOutcome::Valid_move) do
        puts "go to"
        dest_loc = @view.prompt_location
        selectCapture = @model.capture_stone(dest_loc[0], dest_loc[1])
        selectMove = @model.move_stone(dest_loc[0], dest_loc[1])
    end

    @view.display_board(@model)
   end
end