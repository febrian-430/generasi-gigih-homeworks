class Player
    attr_reader :name
    def initialize(name:, hp:, atk_power:)
        @name = name
        @hp = hp
        @atk_power = atk_power
    end

    def is_dead?
        return @hp <= 0
    end

    def get_HP_after_hit(hit_power:)
        hp_after_hit = @hp - hit_power 
        return hp_after_hit < 0 ? 0 : hp_after_hit
    end 

    def receive_hit(hit_power:)
        @hp = self.get_HP_after_hit(hit_power: hit_power)
        puts "#{@name} current hp: #{@hp.to_s}"
    end

    def receive_heal(heal_amount:)
        @hp += heal_amount
        puts "#{@name} current hp: #{@hp.to_s}"
    end
    
    def targeted_action(target:)
        if target.kind_of? Player
            self.hit(target)
        else
            enemy_unit = target.get_random_targeted_member
            self.hit(enemy_unit)
        end
    end

    def hit(target:)
        puts "#{@name} attacks #{target.name} for #{@atk_power.to_s} dmg"
        target.receive_hit(hit_power: @atk_power)
    end
end