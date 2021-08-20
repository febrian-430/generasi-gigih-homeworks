class Report
    def initialize(income, expense, type, date)
        @income = income
        @expense = expense
        @tax = Tax.new(type)
        @date = date
    end
end

#problem
income_tax = report.tax.income(gross_income)

#possible solution
class Report
    def initialize(income, expense, type, date)
        @income = income
        @expense = expense
        @tax = Tax.new(type)
        @date = date
    end

    def income_tax
        return @tax.income(@income)
    end
end

income_tax = report.income_tax