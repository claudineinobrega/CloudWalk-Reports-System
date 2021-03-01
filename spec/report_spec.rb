require 'spec_helper'
 

describe "Report" do
	before :each do
	    @report = Report.new
	end

	it "takes a new game and add a player for it" do
		@report.new_game "game_0"
		players_before = @report.active_players_in_game 0
		pb = players_before.length
		@report.add_player_to_game(0, "1")
		players_after = @report.active_players_in_game 0
		
		pa = players_after.length
		
		expect(pb).not_to eq pa
	end

	it "takes a player and remove it from a game, check active players size" do
		@report.new_game "game_0"
		@report.add_player_to_game(0, "1")

		players_before = @report.active_players_in_game 0
		pb = players_before.length

		@report.remove_player_from_game 0, 1
		
		players_after = @report.active_players_in_game 0
		pa = players_after.length
		
		expect(pb).not_to eq pa
		expect(pa).to eq 1
	end

	it "takes a kill and add to a game and to that player" do
		@report.new_game "game_0"
		@report.add_player_to_game(0, "1")

		kb = @report.kills_of_player_in_game 0, "1022" 
		kb = kb.length
		
		@report.add_kill_to_game 0, "1022", 1, 10
		@report.finish_game 0

		ka = @report.kills_of_player_in_game 0, "1022" 

		expect(kb).not_to eq ka
		expect(ka).to eq 1
	end	
	
	
end