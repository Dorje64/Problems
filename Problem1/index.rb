require 'csv'
require 'pry'

csv = CSV.read('input.csv');

format_hash = {}
group_data = csv.group_by { |data| data[1] }
hash_data = Hash[group_data.map{|k,v| [k,v]}].sort

hash_data.each do |key, value|

  time_diff = []
  transpose_values = value.transpose
  cons_times = transpose_values[0].each_cons(2)

  cons_times.each do |c|
    time_diff << c.sort.inject(0){ |a, b| b.to_i - a.to_i}
  end

  volume = transpose_values[2].inject(0){|sum, e| sum + e.to_i}
  weightedPrice = value.inject(0){|total, e| (total + e[2].to_i * e[3].to_i)}
  format_hash[key] = {
                      symbol: key,
                      MaxTime: time_diff.max,
                      volume: volume,
                      WeightedAveragePrice: weightedPrice/volume,
                      MaxPrice: transpose_values.last.max
                     }
end

puts format_hash
