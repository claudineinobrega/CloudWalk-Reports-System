require 'optparse'
require_relative '../spec/spec_helper'

options = {:game => nil, :opt => nil, :all_games => nil, :file => nil, :json => nil}

OptionParser.new do |parser|
	parser.banner = "Usage: reports_system.rb -f <FILE> [options]"
	parser.on('-g', '--game GAME>', 'Show game summary') do |game|
		options[:game] = game.to_s
	end

	parser.on('-o', '--option OPTION', 'Show option selected in sumary of game') do |opt|
		options[:opt] = opt
	end

	parser.on('-s', '--summary', 'Show game summary') do |summary|
		options[:summary] = summary
	end

	parser.on('-a', '--all_games', 'List all games in log') do |all|
		options[:all_games] = all

	end

	parser.on('-f', '--file FILE', 'Read a file log') do | file |
		options[:file] = file
	end

	parser.on('-j', '--export_to_json FILE', 'Export to json file') do | json |
		options[:json] = json
	end

	parser.on('-h', '--help', 'Displays Help') do
		puts parser
		exit
	end
end.parse!


if(options[:file])

	begin
		parser = Parser.new options[:file]
		parser.read_log
		report = parser.report
	rescue Exception => e
		print "Invalid log file #{options[:file]}\n"
		exit
	end
	if(options[:all_games])
		print report.games_names 
		print "\n"
	elsif(options[:game] and options[:opt])

		if(report.games_names.include?(options[:game]) and ["1", "2", "3"].include?(options[:opt]))
			id_game = report.games_names.index(options[:game])
			case options[:opt]
			when "1"
				players = report.players_names_in_game id_game
				print players
				print "\n"
			when "2"
				kills = report.games[id_game].total_kills
				print kills
				print "\n"
			when "3"
				kills_by_players = report.kills_of_players_in_game id_game
				print kills_by_players
				print "\n"
			else
			end

		end
	elsif(options[:game] || options[:summary])
		print "Summary options of game:\n"
		print "\t 1 - Players names\n"
	    print "\t 2 - Total number of kills\n"
	    print "\t 3 - Total kills by players\n"
	
	elsif(options[:json])
		exported = report.export_to_json options[:json]
		print "Json file generated #{exported}\n"
	end
end