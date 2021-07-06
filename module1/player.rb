class Player
    attr_reader :name
    def initialize(name:, hp:, atk_power:)
        @name = name
        @hp = hp
        @atk_power = atk_power
    end

    def is_dead?
        return @hp == 0
    end

    def deflect?
        return rand(1..100) <= 80 ? true : false
    end

    def get_HP_after_hit(hit_power:)
        @hp - hit_power < 0 ? 0 : @hp - hit_power
    end 

    def receive_hit(hit_power:)
        # probability to deflect
        @hp = self.get_HP_after_hit(hit_power: hit_power)
        puts "#{@name} current hp: #{@hp.to_s}"
    end
    
    def hit(target:)
        puts "#{@name} attacks #{target.name} for #{@atk_power.to_s} dmg"
        target.receive_hit(hit_power: @atk_power)
    end

end