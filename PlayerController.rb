require_relative "Colour"
require_relative "Move_outcome"
class PlayerController
   def initialize(model, view, colour)
      @subject = nil
      @model = model
      @view = view
      @colour = colour
   end
   
   def take_turn()
    text = view.prompt_text
    sel_loc = view.prompt_location
    dest_loc = view.prompt_location
    
    selectResult = model.select_stone(sel_loc[0], sel_loc[1])
    while selectResult != valid_select do
        selectResult = model.select_stone(sel_loc[0], sel_loc[1])
    end
    
    selectCapture = model.capture_stone(dest_loc[0], dest_loc[1])
    selectMove = model.move_stone(dest_loc[0], dest_loc[1])
    while selectCapture != valid_capture && selectMove != valid_move do
        selectCapture = model.capture_stone(dest_loc[0], dest_loc[1])
        selectMove = model.move_stone(dest_loc[0], dest_loc[1])
    end

    display_board(model)

   end
end