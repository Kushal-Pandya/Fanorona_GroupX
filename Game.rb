require_relative "PlayerController"
require_relative "BoardView"
require_relative "BoardModel"
require_relative "MoveOutcome"
class Game
   def initialize()
   	puts "here"
      @view = nil
	  @model = nil
	  @controller = nil
	  
   end
   
   
   def play()
      @model BoardModel.new(5,9)
	  @view = Boardview.new()
	  @view.display_colour_selection()
	  colourIn = @view.prompt_text()
	  if colourIn == "1"
	     p1Controller = PlayerController.new(@model, @view)
		 p2Controller = PlayerController.new(@model, @view)
		 @controller = p1Controller
      else
	     p1Controller = PlayerController.new(@model, @view)
		 p2Controller = PlayerController.new(@model, @view)
		 @controller = p2Controller
	  end
   	  result = @controller.take_turn()
	  while result == MoveOutcome::Turn_over do
	     if @controller == p1Controller
		    @controller = p2Controller
		 else
		    @controller = p1Controller
		 end
		 result = @controller.take_turn()
	  end
   end
end

foo = Game.new()
puts " Iwan to play now"
foo.play()
