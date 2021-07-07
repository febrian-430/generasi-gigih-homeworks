class Game
    def initialize(player1:, player2:)
        @player1 = player1
        @player2 = player2
        @firstPlayerTurn = true
    end

    def turn_action
        if @firstPlayerTurn
            @player1.hit(target: @player2)
        else
            @player2.hit(target: @player1)
        end
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