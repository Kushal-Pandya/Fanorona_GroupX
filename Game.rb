class Game
   def initialize()
      @view = BoardView.initialize()
	  @model = BoardModel.initialize(5,9)
	  
	  @view.display_colour_selection()
	  colourIn = @view.prompt_text()
	  if colourIn == "1"
	     p1Controller = playerController.initialize(@model, @view, Colour::White)
		 p2Controller = playerController.initialize(@model, @view, Colour::Black)
		 @controller = p1Controller
      else
	     p1Controller = playerController.initialize(@model, @view, Colour::Black)
		 p2Controller = playerController.initialize(@model, @view, Colour::White)
		 @controller = p2Controller
	  end
	  
   end
   
   
   def play()
	  result = @controller.take_turn()
	  while result == Outcome::Turn_over do
	     if @controller == p1Controller
		    @controller = p2Controller
		 else
		    @controller = p1Controller
		 end
		 result = @controller.take_turn()
	  end
   end
   
   
   
end