require 'csv'

csv = CSV.read('input.csv');

group_data = csv.group_by { |data| data[1] }
hash_data = Hash[group_data.map{|k,v| [k,v]}].sort

def generate_file(file_name, value)
    CSV.open(file_name, 'a+') do |csv_data|
      csv_data << [ value[:symbol], value[:MaxTime], value[:volume], value[:WeightedAveragePrice], value[:MaxPrice]]
    end
end

def max_time_gap(consecutive_pair_times)
  time_gaps = []
  consecutive_pair_times.each do |pair_time|
    time_gaps << pair_time.sort.inject(0){ |first, last| last.to_i - first.to_i}
  end
  time_gaps.max
end

def volume(transpose_values)
  transpose_values[2].inject(0){|sum, e| sum + e.to_i}
end

def weighted_price(value)
  value.inject(0){|total, e| (total + e[2].to_i * e[3].to_i)}
end

def process_data(hash_data, format_hash = {})
    File.delete('output.csv') if File.exists?('output.csv')

    hash_data.each do |key, value|
      transpose_values = value.transpose
      consecutive_pair_times = transpose_values[0].each_cons(2)

      format_hash[key] = {
                          symbol: key,
                          MaxTime: max_time_gap(consecutive_pair_times),
                          volume: volume(transpose_values),
                          WeightedAveragePrice: weighted_price(value)/volume(transpose_values),
                          MaxPrice: transpose_values.last.max
                         }

      generate_file('output.csv', format_hash[key])
  end

  puts "Processed Data are saved in output.csv file"
end


unless File.exists?('output.csv')
  process_data(hash_data)
else
  puts "output.csv is already there in the directory"
  to_replace = gets
  process_data(hash_data) if to_replace == "y\n"
end
