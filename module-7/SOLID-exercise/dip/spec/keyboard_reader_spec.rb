require './keyboard_reader'

describe KeyboardReader do 
 it "have a name" do
  keyboard_reader = KeyboardReader.new
  expect(keyboard_reader.name).to eq("keyboard")
 end
 it "can read" do
  keyboard_reader = KeyboardReader.new
  expect(keyboard_reader.read("baca")).to eq("keyboard read baca")
 end
end
