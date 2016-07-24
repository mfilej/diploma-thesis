#!/usr/bin/env ruby

require "csv"

col_sep, source_dir = ARGV

max_index = 0
maps =
  Dir.glob(File.join(source_dir, "*.verb.dist")).each_with_object({}) { |path, hash|
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

CSV($stdout, col_sep: col_sep) do |csv|
  csv << ["NumVerbs", *maps.keys]

  0.upto(max_index) do |index|
    row =
      maps.map do |(_name, dist)|
        dist.fetch(index, 0)
      end
    csv << [index, *row]
  end
end
