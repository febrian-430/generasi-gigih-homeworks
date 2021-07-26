class WLI
    attr_reader :names

    def initialize(names = [])
        @names = names
    end

    def likes
        template = ""
        if @names.length <= 1
            template = "#{@names.empty? ? "No one" : @names[0]} likes this"
        elsif @names.length >= 4
            first_two_names = @names[0, 2]
            template = first_two_names.join(", ")
            template += " and #{@names.length - 2} others like this"
        else
            all_names_except_last = @names[0, @names.length-1]
            template = all_names_except_last.join(", ")
            template += " and #{@names[2]} like this"
        end
        return template
    end
end