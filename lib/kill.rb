class Kill
	def initialize killer_id, victim_id, mean_of_death_id
		@killer_id = killer_id
		@victim_id = victim_id
		@mean_of_death_id = mean_of_death_id
	end

	def killer_id
		@killer_id
	end

	def victim_id
		@victim_id
	end

	def mean_of_death_id
		@mean_of_death_id
	end
end