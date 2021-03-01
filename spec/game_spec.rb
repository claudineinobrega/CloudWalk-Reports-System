require 'spec_helper'
 

describe "Game" do
	
	before :each do
	    @game = Game.new 0
	end
    
    it "takes one parameters and returns a Game object" do
        
        expect(@game).to be_an_instance_of Game
    end
    
    
end