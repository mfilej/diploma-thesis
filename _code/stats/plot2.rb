#!/usr/bin/env ruby

require "csv"

col_sep, source_dir = ARGV

max_index = 0
models =
  Dir.glob(File.join(source_dir, "*.gen.verb.dist")).each_with_object({}) { |path, hash|
    pairs =
      File.open(path) do |file|
        file.each_line.map { |line|
          index, value = line.split
          index = Integer(index)
          value = Integer(value)

          max_index = index if index > max_index

          [index, value]
        }
      end

    hash[path] = Hash[pairs]
  }

value_range = 0..max_index

CSV($stdout, col_sep: col_sep) do |csv|
  csv << ["Model", "NumVerbs", "Count"]

  models.each do |(name, dist)|
    value_range.each do |i|
      csv << [name.inspect, i, dist.fetch(i, 0)]
    end
  end
end
