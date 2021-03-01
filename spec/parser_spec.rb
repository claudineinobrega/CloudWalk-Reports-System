require 'spec_helper'
 
describe "Parser" do
	
	before :each do
	    @parser = Parser.new "log/game.txt"
	end
    
    it "takes a log file path and check if its ok" do
    	check_path = @parser.check_path
        expect(check_path).to eq true
    end

    it "takes the path File, and read the File object" do
    	@parser.read_log
    end

    
end