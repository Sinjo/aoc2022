require "set"

class Day04
  PAIR_REGEX = /(?<elf_one_start>\d+)-(?<elf_one_end>\d+),(?<elf_two_start>\d+)-(?<elf_two_end>\d+)/

  ElfPair = Struct.new(:elf_one_start, :elf_one_end, :elf_two_start, :elf_two_end)

  def part_a(input)
    input.
      lines.
      map(&:chomp).
      map { |line| PAIR_REGEX.match(line) }.
      map { |line|
        ElfPair.new(line[:elf_one_start],
                    line[:elf_one_end],
                    line[:elf_two_start],
                    line[:elf_two_end])
      }.map { |line|
        [(line.elf_one_start..line.elf_one_end).to_set, (line.elf_two_start..line.elf_two_end).to_set]
      }.map { |line|
        line.first <= line.last || line.last <= line.first
      }.count(true)
  end

  def part_b(input)
    input.
      lines.
      map(&:chomp).
      map { |line| PAIR_REGEX.match(line) }.
      map { |line|
        ElfPair.new(line[:elf_one_start],
                    line[:elf_one_end],
                    line[:elf_two_start],
                    line[:elf_two_end])
      }.map { |line|
        [(line.elf_one_start..line.elf_one_end).to_set, (line.elf_two_start..line.elf_two_end).to_set]
      }.map { |line|
        (line.first & line.last).size > 0
      }.count(true)
  end
end
