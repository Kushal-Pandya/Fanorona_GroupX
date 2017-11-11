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
        system "clear"
        puts "Fanarona Main Menu"
        puts "Please select an option"
        puts "1. Run game"
        puts "2. Change board size"
        puts "3. Show help"
        puts "4. Quit"
        puts "Make your selection now! (1-4)"
    end
    def display_help()
        system "clear"
        puts "Fanarona Help"
        puts "Rules:"
        puts "Fanorona is a board game played with two players holding black and white pieces "
        puts "on a board. The board is traditionallyrectangular with a 5x9 grid of vertical "
        puts "and horizontal lines along with diagonal lines that intersect on every other "
        puts "stone. Each player starts with 22 stone pieces. The top and bottom two rows are "
        puts "filled with black and white stones respectively. The middle grid intersection "
        puts "of the board is left empty and the remaining 8 positions are filled with an "
        puts "alternating black then white pattern. Additionally, there are two alternate "
        puts "versions of the board layout, in which the game is played on a 3x3 board "
        puts "(Fanoron-Telo), and 5x5 board (Fanoron-Dimy)."
    end
    def display_board(model)
        currentBoard = model
        rows = model.rows
        columns = model.columns
        stonesArr = []
        
        for i in 0..rows-1
            for j in 0..columns-1
                if model.get_stone(i, j).colour == white
                    stonesArr << 'w'
                elsif model.get_stone(i, j).colour == black
                    stonesArr << 'b'
                elsif model.get_stone(i, j) == nil
                    stonesArr << '-'
                end
            end
        end

        if rows == 3
            if columns == 3
                print "#{stonesArr[0]}--#{stonesArr[1]}--#{stonesArr[2]}\n"
                print "|\\ | /|\n"
                print "| \\|/ |\n"
                print "#{stonesArr[3]}--#{stonesArr[4]}--#{stonesArr[5]}\n"
                print "| /|\\ |\n"
                print "|/ | \\|\n"
                print "#{stonesArr[6]}--#{stonesArr[7]}--#{stonesArr[8]}\n"
            else
                puts "Invalid number of columns"
            end
        elsif rows == 5
            if columns == 5
                print "#{stonesArr[0]}--#{stonesArr[1]}--#{stonesArr[2]}--#{stonesArr[3]}--#{stonesArr[4]}\n"
                print "|\\ | /|\\ | /|\n"
                print "| \\|/ | \\|/ |\n"
                print "#{stonesArr[5]}--#{stonesArr[6]}--#{stonesArr[7]}--#{stonesArr[7]}--#{stonesArr[9]}\n"
                print "| /|\\ | /|\\ |\n"
                print "|/ | \\|/ | \\|\n"
                print "#{stonesArr[10]}--#{stonesArr[11]}--#{stonesArr[12]}--#{stonesArr[12]}--#{stonesArr[14]}\n"
                print "|\\ | /|\\ | /|\n"
                print "| \\|/ | \\|/ |\n"
                print "#{stonesArr[15]}--#{stonesArr[16]}--#{stonesArr[17]}--#{stonesArr[18]}--#{stonesArr[19]}\n"
                print "| /|\\ | /|\\ |\n"
                print "|/ | \\|/ | \\|\n"
                print "#{stonesArr[20]}--#{stonesArr[21]}--#{stonesArr[22]}--#{stonesArr[23]}--#{stonesArr[24]}\n"
            elsif columns == 9
                print "#{stonesArr[0]}--#{stonesArr[1]}--#{stonesArr[2]}--#{stonesArr[3]}--#{stonesArr[4]}--#{stonesArr[5]}--#{stonesArr[6]}--#{stonesArr[7]}--#{stonesArr[8]}\n"
                print "|\\ | /|\\ | /|\\ | /|\\ | /|\n"
                print "| \\|/ | \\|/ | \\|/ | \\|/ |\n"
                print "#{stonesArr[9]}--#{stonesArr[10]}--#{stonesArr[11]}--#{stonesArr[12]}--#{stonesArr[13]}--#{stonesArr[14]}--#{stonesArr[15]}--#{stonesArr[16]}--#{stonesArr[17]}\n"
                print "| /|\\ | /|\\ | /|\\ | /|\\ |\n"
                print "|/ | \\|/ | \\|/ | \\|/ | \\|\n"
                print "#{stonesArr[18]}--#{stonesArr[19]}--#{stonesArr[20]}--#{stonesArr[21]}--#{stonesArr[22]}--#{stonesArr[23]}--#{stonesArr[24]}--#{stonesArr[25]}--#{stonesArr[26]}\n"
                print "|\\ | /|\\ | /|\\ | /|\\ | /|\n"
                print "| \\|/ | \\|/ | \\|/ | \\|/ |\n"
                print "#{stonesArr[27]}--#{stonesArr[28]}--#{stonesArr[29]}--#{stonesArr[30]}--#{stonesArr[31]}--#{stonesArr[32]}--#{stonesArr[33]}--#{stonesArr[34]}--#{stonesArr[35]}\n"
                print "| /|\\ | /|\\ | /|\\ | /|\\ |\n"
                print "|/ | \\|/ | \\|/ | \\|/ | \\|\n"
                print "#{stonesArr[36]}--#{stonesArr[37]}--#{stonesArr[38]}--#{stonesArr[39]}--#{stonesArr[40]}--#{stonesArr[41]}--#{stonesArr[42]}--#{stonesArr[43]}--#{stonesArr[44]}\n"
            else
                puts "Invalid number of rows"
            end
        else
            puts "Invalid number of rows"
        end
    end
    def display_colour_selection()
        system "clear"
        puts "Which color would you like to play as?"
        puts "1. White"
        puts "2. Black"
        puts "Make your selection now! (1-2)"
    end
end

