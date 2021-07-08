require_relative "player"

class Playable < Fightable
    attr_writer :group
    def initialize(unit:)
        @unit = unit
        @group = nil
    end

    def can_heal?
        return @unit.instance_of? Hero
    end

    def name 
        return @unit.name
    end

    def action_prompt()
        puts "As #{@unit.name}, what do you want to do in this turn?"
        puts "1) Attack an enemy"
        puts "2) Heal an ally" if @unit.instance_of? Hero || @group == nil
        action = gets.chomp.to_i
        return action
    end

    def get_target_from_prompt(group:)
        target_idx = gets.chomp.to_i
        members = group.get_members
        return members[target_idx-1]
    end

    def attack_prompt(enemy_group:)
        puts "Which enemy do you want to attack?"
        
        enemy_group.get_members.each_with_index do
            |member, i|
            if !member.is_dead?
                puts "#{i+1}). #{member.name}"
            end
        end
        target = self.get_target_from_prompt(group: enemy_group)
        @unit.hit(target: target)
    end

    

    def heal_prompt()
        if self.can_heal? || @group != nil
            puts "Which ally do you want to heal?"
            @group.get_members.each_with_index {
                |member, i|
                if member == self || member.is_dead?
                    next
                end
                puts "#{i+1}). #{member.name} #{member.inspect} #{@unit.inspect}"
            }
            target = self.get_target_from_prompt(group: @group)
            @unit.heal(target: target)
        end
    end

    def receive_hit(hit_power:)
        @unit.receive_hit(hit_power: hit_power)
    end

    def targeted_action(target:)
        action = self.action_prompt
        case action
        when 1
            self.attack_prompt(enemy_group: target)
        when 2
            self.heal_prompt()
        end
    end

    def is_dead?
        return @unit.is_dead?
    end

    def to_s
        return @unit.to_s
    end
end