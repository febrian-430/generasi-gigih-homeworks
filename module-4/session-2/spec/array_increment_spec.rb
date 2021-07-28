require_relative './test_helper'
require_relative '../array_incrementer.rb'

describe ArrayIncrementer do

    it 'should [1] given [0]' do
        expected = [1]
        given = [0]
        actual = ArrayIncrementer.new(given).increment
        expect(actual).to eq(expected)
    end

    it 'should [2] given [1]' do
        expected = [1]
        given = [0]
        actual = ArrayIncrementer.new(given).increment()
        expect(actual).to eq(expected)
    end

    it 'should [1,0] given [9]' do
        expected = [1,0]
        given = [9]
        actual = ArrayIncrementer.new(given).increment()
        expect(actual).to eq(expected)
    end

    it 'should [1,1] given [1,0]' do
        expected = [1,0]
        given = [9]
        actual = ArrayIncrementer.new(given).increment()
        expect(actual).to eq(expected)
    end

    it 'should [2,0] given [1,9]' do
        expected = [2,0]
        given = [1,9]
        actual = ArrayIncrementer.new(given).increment()
        expect(actual).to eq(expected)
    end

    it 'should [8,9,0] given [8,8,9]' do
        expected = [8,9,0]
        given = [8,8,9]
        actual = ArrayIncrementer.new(given).increment()
        expect(actual).to eq(expected)
    end

    it 'should [9,9,9] given [1,0,0,0]' do
        expected = [1,0,0,0]
        given = [9,9,9]
        actual = ArrayIncrementer.new(given).increment()
        expect(actual).to eq(expected)
    end
end