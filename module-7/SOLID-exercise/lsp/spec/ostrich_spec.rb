require './ostrich'

describe Ostrich do 
 it "can sound" do
  ostrich = Ostrich.new
  expect(ostrich.sound).to eq("bark")
 end
 it "won't fly" do
  ostrich = Ostrich.new
  expect{ostrich.fly}.to raise_error("I can't fly")
 end
end
