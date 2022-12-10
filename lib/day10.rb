class Day10
  class Machine

    ITS_LIT = "█"
    ITS_NOT_LIT = " "

    attr_reader :x
    attr_reader :clock_cycle

    def initialize
      @x = 1
      @clock_cycle = 1

      @signal_strengths = []

      @pixels = ""
    end

    def noop
      accumulate_signal

      @clock_cycle = @clock_cycle + 1
    end

    def addx(i)
      accumulate_signal

      @clock_cycle += 1

      accumulate_signal

      @clock_cycle += 1
      @x += i
    end

    def sum_of_signal_strengths
      @signal_strengths.sum
    end

    def render_display
      puts @pixels.chars.each_slice(40).map(&:join).join("\n")
    end

    private

    def accumulate_signal
      if interesting_cycle_part_a?
        @signal_strengths << @x * @clock_cycle
      end

      if [@x - 1, @x, @x +1].include?((@clock_cycle - 1) % 40)
        @pixels << ITS_LIT
      else
        @pixels << ITS_NOT_LIT
      end
    end

    def interesting_cycle_part_a?
      # + 1 because we'll be checking this during the cycle, before we've
      # incremented the clock
      (@clock_cycle - 20) % 40 == 0 && @clock_cycle <= 220
    end
  end

  def part_a(input)
    machine = Machine.new

    input.lines.map(&:chomp).each { |line|
      case line
      when /noop/
        machine.noop
      when /addx (-?\d+)/
        machine.addx Integer($~[1])
      end
    }

    machine.sum_of_signal_strengths
  end

  def part_b(input)
    machine = Machine.new

    input.lines.map(&:chomp).each { |line|
      case line
      when /noop/
        machine.noop
      when /addx (-?\d+)/
        machine.addx Integer($~[1])
      end
    }

    machine.render_display
  end
end
