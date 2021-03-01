require 'spec_helper'
 

describe "Kill" do
	
	before :each do
	    @kill = Kill.new "Player1", "Killed", "Death_Mode"
	end
    
    it "takes three parameters and returns a Kill object" do
        expect(@kill).to be_an_instance_of Kill
    end
    
    
end