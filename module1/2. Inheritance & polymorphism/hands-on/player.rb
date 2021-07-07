class Player < Unit
    attr_reader :name
    def initialize(name:, hp:, atk_power:)
        @current_hp = hp
        @name = name
        @hp = hp
        @atk_power = atk_power
    end

    def is_dead?
        return @hp <= 0
    end

    def get_HP_after_hit(hit_power:)
        hp_after_hit = @current_hp - hit_power 
        return hp_after_hit < 0 ? 0 : hp_after_hit
    end 

    def receive_hit(hit_power:)
        @current_hp = self.get_HP_after_hit(hit_power: hit_power)
        puts "#{@name} current hp: #{@hp.to_s}"
    end
    
    def hit(target:)
        puts "#{@name} attacks #{target.name} for #{@atk_power.to_s} dmg"
        target.receive_hit(hit_power: @atk_power)
    end

end