require_relative './wli'


describe WLI do
    it "has no likes" do
        wli = WLI.new
        expect(wli.likes).to eq("No one likes this")
    end

    it "has one like" do
        wli = WLI.new(["Peter"])
        expect(wli.likes).to eq("Peter likes this")
    end

    it "has three likes" do
        wli = WLI.new(["Peter", "Jacob", "Alex"])
        expect(wli.likes).to eq("Peter, Jacob and Alex like this")
    end

    it "has four or more likes" do
        wli = WLI.new(["Peter", "Jacob", "Alex", "Mark", "Max"])
        expect(wli.likes).to eq("Peter, Jacob and 3 others like this")
    end
end