require_relative "../fightable"
require "./exceptions/incompatible_unit_group_error"

class Playable < Fightable
    attr_writer :group
    def initialize(unit:)
        @unit = unit
        if !unit.kind_of?(Player)
            raise IncompatibleUnitGroupError, "The given object type is incompatible (must be Player type)"
        else
            @unit = unit
        end
        @group = nil
    end

    def can_heal?
        return @unit.instance_of? Hero
    end

    def can_heal_self?
        return false
    end

    def name 
        return @unit.name
    end

    def action_prompt()
        puts "As #{@unit.name}, what do you want to do in this turn?"
        puts "1) Attack an enemy"
        puts "2) Heal an ally" if @unit.instance_of?(Hero) && @group != nil
        action = gets.chomp.to_i
        return action
    end

    def get_target_from_prompt(group_members:)
        target_idx = gets.chomp.to_i
        return group_members[target_idx-1]
    end

    def attack_prompt(enemy_group:)
        puts "Which enemy do you want to attack?"
        enemies = enemy_group.to_a
        enemies.each_with_index do
            |member, i|
            if !member.is_dead?
                puts "#{i+1}). #{member.name}"
            end
        end
        target = self.get_target_from_prompt(group_members: enemies)
        @unit.hit(target: target)
    end

    

    def heal_prompt()
        if self.can_heal? || @group != nil
            puts "Which ally do you want to heal?"
            allies = @group.to_a
            allies.each_with_index {
                |member, i|
                if member == self || member.is_dead?
                    next
                end
                puts "#{i+1}). #{member.name}"
            }
            target = self.get_target_from_prompt(group_members: allies)
            @unit.heal(target: target)
        end
    end

    def receive_hit(hit_power:)
        @unit.receive_hit(hit_power: hit_power)
    end

    def receive_heal(heal_amount:)
        @unit.receive_heal(heal_amount: heal_amount)
    end

    def targeted_action(target:)
        if @group != nil
            action = self.action_prompt
            case action
            when 1
                self.attack_prompt(enemy_group: target)
            when 2
                self.heal_prompt()
            end
        else
            @unit.targeted_action(target: target)
        end
    end

    def is_dead?
        return @unit.is_dead?
    end

    def to_s
        return @unit.to_s
    end
end