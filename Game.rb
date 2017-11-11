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
	  @view = Boardview.new()
	  mainMenuIn = nil
	  rows = 5
	  columns = 9
	  
	  while mainMenuIn != 4 do
	     @view.display_main_menu()
	     mainMenuIn = @view.prompt_text()
	  
	     # selected to play the game
	     if mainMenuIn == "1"
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
	        @model BoardModel.new(rows,columns)
	  
   	        result = @controller.take_turn()
	        while result == MoveOutcome::Turn_over do
	           if @controller == p1Controller
		          @controller = p2Controller
		       else
		          @controller = p1Controller
		       end
		       result = @controller.take_turn()
	        end
		 # selected to change the board size
		 elsif mainMenuIn== "2"
		    sizeCheck = "invalid"
			while sizeCheck == "invalid" do
		       arr = @view.prompt_location()
			   rows = arr[0]
			   columns = arr[1]
			   if (rows == 3 and columns == 3) or (rows == 5 and (columns == 5 or columns == 9))
			      sizeCheck = "valid"
			   end
			end
		 elsif mainMenuIn == "3"
		    @view.display_help()
			@view.prompt_text()
		 elsif mainMenuIn == "4"
		    return
		 else
		    @view.message(" Please enter a valid selection from the main menu.\n Enter any text to return to main menu.")
            @view.prompt_text()
		 end
	  end
   end
end

foo = Game.new()
puts " Iwan to play now"
foo.play()
