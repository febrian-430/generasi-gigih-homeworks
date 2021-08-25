require './salary_calculator'

describe SalaryCalculator do
    context "calculate pay based on level" do
        it "can calculate pay level 1" do
             employee = Employee.new("Dian", "Sasa", 1, 0.2)
             expect(employee.compute_pay).to eq(2400000)
         end
        it "can calculate pay level 2" do
             employee = Employee.new("Dian", "Sasa", 2, 0.2)
             expect(employee.compute_pay).to eq(3200000)
         end
        it "can calculate pay level 3" do
             employee = Employee.new("Dian", "Sasa", 3, 0.2)
             expect(employee.compute_pay).to eq(4000000)
         end
         it "return error for unknown level" do
             employee = Employee.new("Dian", "Sasa", 4, 0.2)
             expect(employee.compute_pay).to eq("unknown level")
         end
     end
end