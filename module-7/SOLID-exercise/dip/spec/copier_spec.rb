require './copier'
require './keyboard_reader'
require './printer'
require './network_printer'
require './scanner'




describe Copier do 
    it "can copy input" do
        reader = KeyboardReader.new
        writer = Printer.new

        copier = Copier.new

        expect(copier.copy("SOLID Principles", reader, writer)).to eq("printer prints 'SOLID Principles' from keyboard")
    end

    it "can read from scanner and write with network printer" do
        reader = Scanner.new
        writer = NetworkPrinter.new

        copier = Copier.new

        expect(copier.copy("SOLID Principles", reader, writer)).to eq("network printer prints 'SOLID Principles' from Scanner")
    end
end
