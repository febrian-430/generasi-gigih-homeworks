class Game
    def initialize(team1:, team2:)
        #raise error if not a group
        @team1 = team1
        @team2 = team2
        @turn_count = 1
    end

    def turn_action
        puts "==================================================="
        puts "TURN: #@turn_count"
        puts @team1.to_s
        puts 
        puts @team2.to_s
        puts 

        @team1.targeted_action(target: @team2)
        puts
        @team2.targeted_action(target: @team1)
        @team1.update_state
        @team2.update_state

        @turn_count+=1

    end

    def simulate 
        loop do
            if @team1.is_dead? 
                puts "#{@team2.name} wins"
                break
            elsif @team2.is_dead?
                puts "#{@team1.name} wins"
                break
            end
            self.turn_action
            puts ""
        end
    end
end