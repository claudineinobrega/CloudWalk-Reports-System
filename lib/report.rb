require_relative "game"
require 'json'

class Report
	def initialize
		@games = []
	end

	def new_game game_name
		game = Game.new game_name
		@games << game
	end

	def games
		@games
	end

	def players_of_game id_game
		@games[id_game].players
	end

	def active_players_in_game id_game
		@games[id_game].active_players
	end

	def kills_of_game id_game
		@games[id_game].kills
	end

	def add_player_to_game id_game, id_player
		player = Player.new id_player
		@games[id_game].new_player id_player
	end

	def set_player_name_in_game id_game, id_player, p_name
		@games[id_game].set_player_name id_player, p_name
	end

	def remove_player_from_game id_game, id_player
		@games[id_game].remove_player(id_player)
	end

	def add_kill_to_game id_game, killer, victim, mean_of_death
		kill = Kill.new killer, victim, mean_of_death
		@games[id_game].add_kill kill
	end

	def kills_of_player_in_game id_game, id_player
		@games[id_game].kills_of_player id_player
	end

	def kills_of_players_in_game id_game
		@games[id_game].kills_of_players
	end

	def finish_game id_game
		@games[id_game].finish
	end

	def players_names_in_game id_game
		@games[id_game].players_names
	end

	def games_names
		games_names = []
		@games.each do | game |
			games_names << game.g_name
		end
		return games_names
	end

	def export_to_json file
		reportsHash = {}
		
		@games.each_with_index do | game, i |
			gameHash = {
				"total_kills" => game.total_kills,
				"players" => game.players_names,
				"kills" => game.kills_of_players
			}
			
			reportsHash["game_#{i}"] = gameHash
		end

		File.open(file,"w") do |f|
		  f.write(reportsHash.to_json)
		end
		return file
	end
	
end