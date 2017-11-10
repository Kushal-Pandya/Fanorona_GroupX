class BoardView
    def initialize()
        @subject = nil
        @currentBoard = nil
    end
    def prompt_text()
        puts "Enter a string"
        gets.chomp
    end
    def prompt_location()
        puts "Enter row"
        row = Integer(gets.chomp)
        puts "Enter column"
        col = Integer(gets.chomp)
        arr = [row, col]
    end
    def message(text)
        puts text
    end
    def display_main_menu()
        puts "Fanarona Main Menu"
        puts "Please select an option"
        puts "1. Run game"
        puts "2. Change board size"
        puts "3. Show help"
        puts "4. Quit"
        puts "Make your selection now! (1-4)"
    end
    def display_help()
        puts "Fanarona Help"
        puts "Rules:"
        puts "Fanorona is a board game played with two players holding black and white pieces "
        puts "on a board. The board is traditionallyrectangular with a 5x9 grid of vertical "
        puts "and horizontal lines along with diagonallines that intersect on every other "
        puts "stone. Each player starts with 22 stone pieces. The top and bottom two rows are "
        puts "filled with black and white stones respectively. The middle grid intersection "
        puts "of the board is left empty and the remaining 8 positions are filled with an "
        puts "alternating black then white pattern. Additionally, there are two alternate "
        puts "versions of the board layout, in which the game is played on a 3x3 board "
        puts "(Fanoron-Telo), and 5x5 board (Fanoron-Dimy)."
    end
    def display_board(model)
        currentBoard = model
        
    end
    def display_colour_selection()
        puts "Which color would you like to play as?"
        puts "1. White"
        puts "2. Black"
        puts "Make your selection now! (1-2)"
    end
end

