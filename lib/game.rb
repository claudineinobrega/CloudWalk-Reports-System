require 'active_support/core_ext/hash' 
require_relative 'player'

class Game
	
	def initialize game_name
		@g_name = game_name
		player = Player.new("1022" )
		player.set_name "world"
		@active_players = { "1022" => player }
		@players = []
		@kills = []
	end

	def g_name
		@g_name
	end

	def new_player id
		player = Player.new(id.to_s)
		@active_players[id.to_s] = player
	end

	def set_player_name id, p_name
		@active_players[id.to_s].set_name p_name
	end

	def players
		@players
	end

	def active_players
		@active_players
	end

	def add_kill kill
		@kills << kill
	end

	def kills
		@kills
	end

	def remove_player id_player
		count_kills = computes_kill_to_player id_player
		player = @active_players[id_player.to_s].dup
		players << {"#{id_player}" => player, "kills" => count_kills}
		@active_players.delete(id_player.to_s)
	end

	def add_kill kill
		@kills << kill
		id_player = kill.killer_id

		@active_players[id_player].add_kill kill 
	end

	def total_kills
		tot_kills = 0
		@players.each do | player |
			tot_kills += player["kills"]
		end
		return tot_kills
	end

	def kills_of_player id_player
		@players.each do | player |
			if player["#{id_player}"]
				return player["kills"]
			end
		end
		# @players[id_player.to_s].kills 
	end

	def finish
		@active_players.each do | id, player |
			count_kills = computes_kill_to_player id
			@players << {"#{id}" => player, "kills" => count_kills}
		end
		@active_players = []
	end

	def players_names
		player_names = []
		@players.each do | player |
			if(!player["1022"])
				player_names << player[player.keys[0]].p_name
			end
		end
		return player_names
	end

	def kills_of_players
		kills_of_p = []
		@players.each do | player |
			if(!player.keys[0].eql?("1022"))
				kills_of_p << { player[player.keys[0]].p_name => player["kills"]} 
			end
		end
		return kills_of_p
	end

	private
	def computes_kill_to_player id
		tot_kills = 0
		@kills.each do | kill |
			if kill.killer_id.eql?(id)
				tot_kills += 1
			end
		end
		@kills.each do | kill |
			if kill.victim_id.eql?(id) and kill.killer_id.eql?("1022")
				if(tot_kills > 0)
					tot_kills -= 1
				end
			end
		end
		return tot_kills
	end

end