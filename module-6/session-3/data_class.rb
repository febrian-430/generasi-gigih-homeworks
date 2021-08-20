#problem
class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
        @start_date = start_date
        @end_date = end_date
    end
end

#client code
def average_income_in(date_range)
    #...

    total_days = (date_range.end_date - date_range.start_date).to_i
    total_income/total_days
end

#solution
class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
        @start_date = start_date
        @end_date = end_date
    end

    def interval
        (@end_date-@start_date).to_i
    end
end

def average_income_in(date_range)
    #...
    
    total_days = date_range.interval
    total_income/total_days
end