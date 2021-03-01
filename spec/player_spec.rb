require 'spec_helper'
 

describe "Player" do
	before :each do
	    @player = Player.new "0"
	end

	it "takes a new player and add a kill for it" do
		size_kills = @player.kills.length
		kill = Kill.new 0, 1, 10
		@player.add_kill kill
		expect(@player.kills.length).not_to eq size_kills
		expect(@player.kills.length).to eq 1
	end
	
	
end