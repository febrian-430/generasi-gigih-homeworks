def get_total_net_income(reports)
    total_net_income = 0
    reports.each do |report|
        gross_income = report.income - report.expense
        net_income = report.tax.income_tax(gross_income)
        total_net_income = total_netincome + net_income
    end
    return total_net_income
end

#solution 1
def get_total_net_income(reports)
    total_net_income = 0
    reports.each do |report|
        net_income = get_net_income(report)
        total_net_income = total_net_income + net_income
    end
    return total_net_income
end

def get_net_income(report)
    gross_income = get_gross_income(report)
    return report.tax.income_tax(gross_income)
end

def get_gross_income(report)
    return report.income - report.expense
end


#solution 2

class Report
    #...
    def gross_income
        return @income - @expense
    end

    def net_income
        gross_income = self.gross_income
        return @tax.income_tax(gross_income)
    end
end

def get_total_net_income(reports)
    total_net_income = 0
    reports.each do |report|
        net_income = report.net_income
        total_net_income = total_net_income + net_income
    end
    return total_net_income
end