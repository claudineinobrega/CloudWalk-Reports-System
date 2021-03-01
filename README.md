# CloudWalk Reports System

Project of Game Reports System from the Software Engineer test of **CloudWalk**

## Description

This project was made for the Software Engineer test of **CloudWalk**.
Was developed in Ruby language with use of Rspec for UnitTest and BDD and make use of OptionParser gem to generate a command line app.

### How to run
> $ cd path/to/project/cloudwalk_reports/ <br>
> $ bundle install <br>
> $ ruby bin/reports_system.rb -f <LOG FILE> [options]

### Examples

Games List
> $ ruby bin/reports_system.rb -f log/game.txt -g <br>
> ["game0", "game1", "game2", "game3", "game4", ...] 


Games Summary
> $ ruby bin/reports_system.rb -f log/game.txt -g game_1 <br>
> Summary of game: <br>
> 	1 - Player names <br>
>	2 - Total number of kills <br>
>	3 - Total kills by players


Listing Names of Game Players
> $ ruby bin/reports_system.rb -f log/game.txt -g game_0 -o 1 <br>
> ["Isgalamido"]

Total Number of Kills in a Game
> $ ruby bin/reports_system.rb -f log/game.txt -g game_0 -o 2 <br>
> 0

Total Kills by Players
> $ ruby bin/reports_system.rb -f log/game.txt -g game_0 -o 3 <br>
> [{"Isgalamido"=>0}]

Export to Json file
> $ ruby bin/reports_system.rb -f log/game.txt -e text.json <br>
> Json file generated text.json

Help Page
> $ ruby bin/reports_system.rb -h <br>
>Usage: reports_system.rb -f <FILE> [options] <br>
>    -g, --game GAME>                 Show game summary <br> 
>    -o, --option OPTION              Show option selected in summary of game <br>
>    -s, --summary                    Show games summary <br>
>    -a, --all_games                  List all games in log <br>
>    -f, --file FILE                  Read a file log <br> 
>    -j, --export_to_json FILE        Export to json file <br>
>    -h, --help                       Displays Help
