require_relative './simple_encoder'

describe SimpleEncoder do
    it 'should return empty string' do
        encoder = SimpleEncoder.new
        encoded = encoder.encode('')
        expect(encoded).to eq('')
    end


    it 'should encode b to k' do
        encoder = SimpleEncoder.new
        encoded = encoder.encode('b')
        expect(encoded).to eq('k')
    end

    it 'should encode z to i' do
        encoder = SimpleEncoder.new
        encoded = encoder.encode('z')
        expect(encoded).to eq('i')
    end
end