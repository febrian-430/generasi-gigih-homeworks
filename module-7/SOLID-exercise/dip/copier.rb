class Copier
	def copy(input, reader, writer)
		reader.read(input)
		writer.write(input, reader.name)
	end
end
