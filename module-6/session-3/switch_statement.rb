#problem

class Tax
    def income_tax(gross_income)
        case @type
        when 'INDIVIDUAL'
            gross_income * 0.1
        when 'ENTERPRISE'
            gross_income * 0.2
        when 'GOVERNMENT'
            gross_income * 0.05
        else gross_income * 0.3
    end
    #other methods with related switch statements
end

#possible solution
class TaxFactory
    def self.create(variables, type)
        case type
        when 'INDIVIDUAL'
            IndividualTax.new(variables)
        when 'ENTERPRISE'
            EnterpriseTax.new(variables)
        when 'GOVERNMENT'
            GovernmentTax.new(variables)
        else Tax.new(variables)
        end
    end
end

class Taxable

    def income_tax(gross_income)
        raise NotImplementedError
    end

    #and other methods
end

class Tax < Taxable
    def income_tax(gross_income)
        gross_income * 0.3
    end
end

class IndividualTax < Taxable
    def income_tax(gross_income)
        gross_income * 0.1
    end
end

class EnterpriseTax < Taxable
    def income_tax(gross_income)
        gross_income * 0.2
    end
end

class GovernmentTax < Taxable
    def income_tax(gross_income)
        gross_income * 0.05
    end
end

tax = TaxFactory.create("INDIVIDUAL")