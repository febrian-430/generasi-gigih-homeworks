class Game
    def initialize(group1:, group2:)
        @group1 = group1
        @group2 = group2
        @turn_count = 1
    end

    def get_target_from_prompt(group:)
        target_idx = gets.chomp.to_i
        target = group[target_idx-1]
    end

    def attack_prompt(hero:, enemy_group:)
        puts "Which enemy do you want to attack?"
        @group2.each_with_index {
            |member, i|
            if !member.is_dead?
                puts "#{i+1}). #{member.name}"
            end
        }
        target = self.get_target_from_prompt(group: enemy_group)
        hero.hit(target: target)
    end

    def heal_prompt(hero:, allies:)
        puts "Which ally do you want to heal?"
        @group1.each_with_index {
            |member, i|
            if member.instance_of?(Hero) || member.is_dead?
                next
            end
            puts "#{i}). #{member.name}"
        }
        target = self.get_target_from_prompt(group: allies)
        hero.heal(target: target)
    end

    def turn_action
        @group1.each_with_index do |ally, i|
            if ally.instance_of?(Hero)
                puts "As #{ally.name}, what do you want to do in this turn?"
                puts "1) Attack an enemy"
                puts "2) Heal an ally"
                action = gets.chomp.to_i
                case action
                when 1
                    self.attack_prompt(hero: ally, enemy_group: @group2)
                when 2
                    self.heal_prompt(hero: ally, allies: @group1)
                end
            elsif !ally.is_dead? && @group2.length != 0
                target_idx = rand(0..@group2.length)
                target = @group2[target_idx]
                if target != nil 
                    ally.hit(target: target)
                end
            end
        end

        @group2.each_with_index do |enemy, i|
            if !enemy.is_dead? && @group1.length != 0
                target_idx = rand(0..@group1.length)
                target = @group1[target_idx]
                if target != nil 
                    enemy.hit(target: target)
                end
            end
        end

        @turn_count+=1
    end

    def simulate 
        loop do
            self.update_state
            if @group1.length == 0 
                puts "Mongols win"
                break
            elsif @group2.length == 0
                puts "Jin Sakai's party wins"
                break
            end
            self.turn_action
            puts ""
        end
    end

    def update_state
        @group1.delete_if { |member| member.is_dead? }
        @group2.delete_if { |enemy| enemy.is_dead? }
    end
end