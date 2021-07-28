class ArrayIncrementer
    def initialize(nums = [0])
        @nums = nums
    end

    def increment
        @nums.reverse!
        self.iter_increment
        @nums.reverse!
        return @nums
    end

    def iter_increment
        last = -1
        carry = false
        @nums.each_with_index do |num, i|
            last = num
            if num != 9
                @nums[i] += 1
                carry = false
                break
            elsif carry == true
                @nums[i] = 0
                next
            else
                @nums[i] = 0
                carry = true
            end
        end
        if last == 9 && carry == true
            @nums << 1
        end
    end
end