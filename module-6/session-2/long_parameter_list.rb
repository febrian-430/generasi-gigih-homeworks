def total_income_in(start_date, end_date, reports)

end

def total_expense_in(start_date, end_date, reports)
end

def total_net_income_in(start_date, end_date, reports)
end

#refactored

def Interval
    def initialize(start_date, end_date)
        @start_date = start_date
        @end_date = end_date
    end
end


def total_income_in(time_interval, reports)

end

def total_expense_in(time_interval, reports)
end

def total_net_income_in(time_interval, reports)
end

# imo refactor 2
class ReportCalculator 
    def initialize(time_interval, reports)
        @time_interval = time_interval
        @reports = reports
    end

    def income

    end

    def expense

    end

    def net_income

    end
end