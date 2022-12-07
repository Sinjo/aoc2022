require "pathname"
require "set"

class Day07
  def part_a(input)
    all_directories, file_sizes = parse(input)

    Hash[all_directories.map { |dir|
      if dir.to_s == "/"
        total_size = file_sizes.values.sum
      else
        total_size = file_sizes.filter { |file, _|
          file.to_s.start_with?(dir.to_s + "/")
        }.values.sum
      end

      [dir, total_size]
    }].filter { |dir, size|
      size <= 100_000
    }.values.sum
  end

  def part_b(input)
    all_directories, file_sizes = parse(input)

    directory_sizes = Hash[all_directories.map { |dir|
      # This wouldn't need to be a separate case if I deduped // later on
      if dir.to_s == "/"
        total_size = file_sizes.values.sum
      else
        total_size = file_sizes.filter { |file, _|
          file.to_s.start_with?(dir.to_s + "/")
        }.values.sum
      end

      [dir, total_size]
    }]

    available = 70_000_000 - directory_sizes[Pathname.new("/")]
    needed_for_update = 30_000_000 - available

    directory_sizes.reject { |_, size|
      size < needed_for_update
    }.values.min
  end

  private

  def parse(input)
    current_path = Pathname.new("/")
    all_directories = Set.new
    file_sizes = {}

    lines = input.lines.map(&:chomp)

    lines.each do |line|
      if line.start_with?("$")
        case line
        when /^\$ cd (\/.*)/
          current_path = Pathname.new(Regexp.last_match[1])
          all_directories.add(current_path)
        when /^\$ cd \.\./
          current_path = current_path.parent
          all_directories.add(current_path)
        when /^\$ cd (.+)/
          current_path = current_path.join(Regexp.last_match[1])
          all_directories.add(current_path)
        end
      else
        case line
        when /^(\d+) ([a-zA-Z.]+)/
          file_sizes[current_path.join(Regexp.last_match[2])] = Integer(Regexp.last_match[1])
        end
      end
    end

    [all_directories, file_sizes]
  end
end


# 1963230 - too low
