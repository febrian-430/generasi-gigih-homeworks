class SimpleEncoder

    MAX_ORD = 'z'.ord
    MIN_ORD = 'a'.ord
    VOWEL_CHARS=['a', 'i', 'u', 'e', 'o']

    VOWEL_ENCODER_NUM = 5
    CONSONANT_ENCODER_NUM = 9

    def encode(characters)
        output = ''
        characters.each_char do |character| 
            output << encode_char(character)
        end
        output
    end

    def encode_char(character)
        if VOWEL_CHARS.include? character
            ord = character.ord
            new_ord = ord - VOWEL_ENCODER_NUM
            if new_ord >= MIN_ORD
                new_ord.chr
            else
                diff = MIN_ORD - new_ord
                new_ord = MAX_ORD - diff + 1
                new_ord.chr
            end
        elsif character == ''
            return ''
        else
            ord = character.ord
            new_ord = ord+CONSONANT_ENCODER_NUM
            if new_ord <= MAX_ORD
                new_ord.chr
            else
                diff = new_ord - MAX_ORD
                new_ord = MIN_ORD + diff - 1
                new_ord.chr
            end
        end
    end
end