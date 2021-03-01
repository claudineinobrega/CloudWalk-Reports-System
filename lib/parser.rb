require 'fileutils'

class Parser
	@@actions = {
		"InitGame" => "",
		"Exit" => "",
		"ClientConnect" => {
			"id_user" => /ClientConnect: (.*)/
		},
		"ClientUserinfoChanged" => {
			"user_name" => /n\\(.*?)\\t/m,
			"id_user" => /ClientUserinfoChanged: ([0-9]+) n/
		},
		"ClientBegin" => {
			"id_user" => /ClientBegin: (.*)/
		},
		"ClientDisconnect" => {
			"id_user" => /ClientDisconnect: (.*)/	
		},
		"ShutdownGame" => "",
		"Item" => "",
		"Kill" => {
			"killer" =>  /Kill: ([0-9]+)/,
			"victim" => /Kill: [0-9]+ ([0-9]+)/,
			"mean_of_death" => /Kill: [0-9]+ [0-9]+ ([0-9]+):/ 
		},
		"score" => ""
	}

	@@means_of_death = [
		"MOD_UNKNOWN", 			# 0
		"MOD_SHOTGUN", 			# 1
		"MOD_GAUNTLET",			# 2 
		"MOD_MACHINEGUN",		# 3 
		"MOD_GRENADE",			# 4
		"MOD_GRENADE_SPLASH",	# 5
		"MOD_ROCKET",			# 6
		"MOD_ROCKET_SPLASH",	# 7
		"MOD_PLASMA",			# 8
		"MOD_PLASMA_SPLASH",	# 9
		"MOD_RAILGUN",			# 10
		"MOD_LIGHTNING",		# 11
		"MOD_BFG",				# 12
		"MOD_BFG_SPLASH",		# 13
		"MOD_WATER",			# 14
		"MOD_SLIME",			# 15
		"MOD_LAVA",				# 16
		"MOD_CRUSH",			# 17
		"MOD_TELEFRAG",			# 18
		"MOD_FALLING",			# 19
		"MOD_SUICIDE",			# 20
		"MOD_TARGET_LASER",		# 21
		"MOD_TRIGGER_HURT",		# 22
		"MOD_NAIL",				# 23
		"MOD_CHAINGUN",			# 24
		"MOD_PROXIMITY_MINE",	# 25
		"MOD_KAMIKAZE",			# 26
		"MOD_JUICED",			# 27
		"MOD_GRAPPLE"			# 28
	]

	def initialize path
		@time_regex = /([0-1]?\d|2[0-3]):([0-5]?\d)/
		@path = path
		# @path = File.join(File.dirname(__FILE__), path)
		@game_id = -1

		@report = Report.new
		
	end
	def report
		@report
	end

	def check_path
		@path ? true : false
	end

	def read_log
		File.open(@path, "r") do |f|
		  f.each_line do |line|

		    read_line(line)

		  end
		end
	end


	def read_line line
		@@actions.keys.each do | action |
			line[action+":"] ? ( return read_action(action, line) ) : false
		end
	end

	def read_action action, line
		commands = @@actions[action]
		case action
		when "InitGame"

			if (@game_id != -1)
				players = @report.active_players_in_game @game_id
				if (players.length > 0)
					@report.finish_game @game_id
				end
			end
			@game_id += 1

			@report.new_game "game_#{@game_id}"
		when "Exit"
			# @report.finish_game @game_id

		when "ClientConnect"
			id_user = line[commands["id_user"],1]
			@report.add_player_to_game @game_id, id_user


		when "ClientUserinfoChanged"
			id_user = line[commands["id_user"], 1]
			p_name = line[commands["user_name"],1]
			@report.set_player_name_in_game @game_id, id_user, p_name
			

		when "ClientBegin"
		
			

		when "ClientDisconnect"
			id_user = line[commands["id_user"],1]
			@report.remove_player_from_game @game_id, id_user
		when "ShutdownGame"

			@report.finish_game @game_id
		when "Item"

		when "Kill"
			killer = line[commands["killer"], 1]
			victim = line[commands["victim"], 1]
			mean_of_death = line[commands["mean_of_death"], 1]

			@report.add_kill_to_game @game_id, killer, victim, mean_of_death

		when "score"
		else
		end

		return action
	end

	
end