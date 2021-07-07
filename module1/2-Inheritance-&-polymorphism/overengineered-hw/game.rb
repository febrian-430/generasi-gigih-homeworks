class Game
    def initialize(player1:, player2:)
        @player1 = player1
        @player2 = player2
        @turn_count = 1
    end

    def turn_action
        puts "turn: #@turn_count"
        @player1.targeted_action(target: @player2)
        @player2.targeted_action(target: @player1)
        @turn_count+=1
    end

    def next_turn
        @firstPlayerTurn = !@firstPlayerTurn
    end

    def simulate 
        loop do
            if @player1.is_dead? 
                puts "#{@player2.name} wins"
                break
            elsif @player2.is_dead?
                puts "#{@player1.name} wins"
                break
            end
            self.turn_action
            puts ""
            self.next_turn
        end
    end
end