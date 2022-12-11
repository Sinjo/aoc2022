class Day11
  class Monkey
    attr_accessor :items, :operation, :divisor, :if_true, :if_false, :items_inspected

    def initialize
      @items_inspected = 0
    end

    def to_s
      puts <<~EOMONKEY
        Items: #{items}
        Operation: #{operation}
        Divisor: #{divisor}
        If true: #{if_true}
        If false: #{if_false}

        Items inspected: #{items_inspected}
      EOMONKEY
    end
  end

  def part_a(input)
    monkeys = parse_monkeys(input)

    # each round
    20.times do
      # each turn
      monkeys.each_with_index do |monkey, _|
        monkey.items_inspected += monkey.items.size

        # first we inspect, performing the per-monkey operation
        new_scores = monkey.items.map { |item| monkey.operation.call(item) / 3 }

        trues, falses = new_scores.partition { |score| score % monkey.divisor == 0 }

        monkeys[monkey.if_true].items += trues
        monkeys[monkey.if_false].items += falses

        monkey.items.clear
      end
    end

    monkeys.sort { |x, y| x.items_inspected <=> y.items_inspected }.map(&:items_inspected).last(2).reduce(&:*)
  end

  def part_b(input)
  end

  def parse_monkeys(input)
    split_per_monkey = input.lines.map(&:chomp).
      reduce([[]]) { |res, line|
        if line == ""
          next res.append([])
        else
          next res[0...-1].append(res.last.append(line))
        end
      }

    monkeys = split_per_monkey.map { |monkey_input|
      monkey = Monkey.new

      monkey_input.each do |line|
        case line
        when /Starting items: (.+)/
          monkey.items = $~[1].split(", ").map { |item| Integer(item) }
        when /Operation: (.+)/
          # convert monkey lambda syntax into ruby lambda syntax
          monkey.operation = eval "->(old) { #{$~[1]} }"
        when /Test: divisible by (\d+)/
          monkey.divisor = Integer($~[1])
        when /If true.*monkey (\d+)/
          monkey.if_true = Integer($~[1])
        when /If false.*monkey (\d+)/
          monkey.if_false = Integer($~[1])
        end
      end

      monkey
    }
  end
end
