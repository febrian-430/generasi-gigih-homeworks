class SimpleEncoder

    MAX_ORD = 'z'.ord
    MIN_ORD = 'a'.ord

    def encode(str)
        if str == ''
            return ''
        else
            ord = str.ord
            new_ord = ord+9
            if new_ord <= MAX_ORD
                return new_ord.chr
            else
                diff = new_ord - MAX_ORD
                new_ord = MIN_ORD + diff - 1
                return new_ord.chr
            end
        end
    end
end