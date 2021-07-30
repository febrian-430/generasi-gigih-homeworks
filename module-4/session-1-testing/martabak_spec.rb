require_relative './martabak'

describe Martabak do
    it "is delicious" do #case / behavior / scenario
        martabak = Martabak.new("telor")
        taste = martabak.taste
        expect(taste).to(eq("martabak telor is delicious"))
    end
end