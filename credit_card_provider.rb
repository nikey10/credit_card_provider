# frozen_string_literal: true

# Processing Credit Card
class CreditCardProvider
  attr_accessor :cards, :command_history

  def initialize(str)
    @cards = {}

    @command_history = str.lines.map { |line| line.split(' ') }
  end

  def query
    process_command
    generate_summury
  end

  def luhn_pass?(str)
    return false if str.length > 19

    arr = str.reverse.chars.map(&:to_i)
    arr.each_index { |i| arr[i] += arr[i] if i.odd? }
    arr.map! { |el| el / 10 + el % 10 }
    (arr.sum % 10).zero?
  end

  private

  def process_command
    @command_history.each do |cmd_argv|
      case cmd_argv[0]
      when 'Add'
        add_new_card(cmd_argv[1], cmd_argv[2], to_amount(cmd_argv[3]))
      when 'Charge'
        change_balance(cmd_argv[1], to_amount(cmd_argv[2]))
      when 'Credit'
        change_balance(cmd_argv[1], -to_amount(cmd_argv[2]))
      end
    end
  end

  def generate_summury
    @cards.map do |key, value|
      balance = value[:balance]
      balance = "$#{balance}" if balance != 'error'
      "#{key}: #{balance}"
    end.sort
  end

  def add_new_card(owner, number, limit)
    new_card = { number: number, limit: limit, balance: 0 }
    new_card[:balance] = 'error' unless luhn_pass?(number)
    @cards[owner] = new_card
  end

  def change_balance(owner, amount)
    balance = @cards[owner][:balance]

    return if balance == 'error'

    balance += amount
    @cards[owner][:balance] = balance if balance <= @cards[owner][:limit]
  end

  def to_amount(doller_expression)
    doller_expression.delete('$').to_i
  end
end
