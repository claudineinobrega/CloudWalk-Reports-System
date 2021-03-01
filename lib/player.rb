class Player
	
	def initialize id
		@id = id
		@p_name = ""
		@kills = []
		@items = []
	end

	def set_name p_name
		@p_name = p_name
	end

	def add_kill kill
		@kills << kill
	end

	def kills
		@kills
	end

	def add_item item
		@items << item
	end

	def items
		@items
	end

	def p_name
		@p_name
	end

end