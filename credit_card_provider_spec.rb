# frozen_string_literal: true

require 'rspec'
require './credit_card_provider'

# rubocop:disable Metrics/BlockLength
describe 'class CreditCardProvider' do
  context 'given an invalid card number' do
    let(:card_with_invalid_number) { "Add Eric 36459234232234584 $2000\nCredit Eric $500" }

    it 'should be error' do
      card_proc = CreditCardProvider.new(card_with_invalid_number)
      expect(card_proc.query.last).to eq('Eric: error')
    end
  end

  context 'given input' do
    let(:input_file_name1) { 'sample1.txt' }
    let(:input_file_name2) { 'sample2.txt' }

    from_file = lambda do |filename|
      fptr = File.open(filename, 'r')

      if fptr
        initial_str = fptr.read
        fptr.close
      end

      initial_str
    end

    it 'official sample data' do
      expect_result = ['Lisa: $-93', 'Quincy: error', 'Tom: $500']
      card_proc = CreditCardProvider.new(from_file.call(input_file_name1))
      test_result = card_proc.query
      expect(test_result).to eq(expect_result)
    end

    it 'some other sample data' do
      expect_result = ['C++: error', 'Java: $0', 'Python: $-500', 'Ruby: $500']
      card_proc = CreditCardProvider.new(from_file.call(input_file_name2))
      test_result = card_proc.query
      expect(test_result).to eq(expect_result)
    end
  end
end
# rubocop:enable Metrics/BlockLength
