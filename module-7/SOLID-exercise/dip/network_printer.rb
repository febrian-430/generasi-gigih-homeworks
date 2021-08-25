require_relative 'writer'

class NetworkPrinter < Writer
    def write(input, reader_name)
		"network printer prints '#{input}' from #{reader_name}"
    end
end