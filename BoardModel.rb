class BoardModel
	def initialize(rows, columns)
		@stones = nil
	  	@rows= rows
	  	@columns = columns
	  	rules = nil
	  	subject = nil
		select_stone = nil
   	end
   	def get_stone(row, column)
   	end
	def select_stone(row, column)
   	end
	def move_stone(row, column)
   	end
   	def capture_stone(row, column)
   	end
end

class FanoronaBoardModel < BoardModel
	def reset_stones()
	end
end