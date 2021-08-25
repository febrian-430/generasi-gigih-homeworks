require './printer'

describe Printer do 
 it "can write" do
  printer = Printer.new
  expect(printer.write("SOLID Principles", "scanner")).to eq("printer prints 'SOLID Principles' from scanner")
 end
end
