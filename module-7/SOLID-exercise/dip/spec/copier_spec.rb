require './copier'

describe Copier do 
 it "can copy input" do
  copier = Copier.new
  expect(copier.copy("SOLID Principles")).to eq("printer prints 'SOLID Principles' from keyboard")
 end
end
