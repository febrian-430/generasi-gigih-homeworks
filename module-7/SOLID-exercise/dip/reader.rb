class Reader
    def name
        self.class
    end

    def read(input)
        raise NotImplementedError
    end
end