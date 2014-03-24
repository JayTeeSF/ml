module Ml
  class Cluster
    def self.score(options={})
      new(options).score
    end

    def initialize(options={})
      #puts "got options: #{options.inspect}"
      @data_sets = options[:readable_data_sets]
      @compressor = options[:compressor]
      @compressor_args = options[:compressor_args]
      @file_data = {} # possibly a horrible abuse of resources (i.e. memory)
    end

    def score
      results = pairwise_data_set_enumerable.map {|data_set_1, data_set_2|
        # puts "ds1: #{data_set_1[:name].inspect}; ds2: #{data_set_2[:name].inspect}"
        {:data_sets => [data_set_1[:name], data_set_2[:name]], :score => calculate_a_score(data_set_1, data_set_2) }
      }
      results.sort {|a,b| b[:score] <=> a[:score]}
    end

    private
    def compressed_size_for(data_set_data)
      @compressor.deflate(data_set_data,   @compressor_args).size
    end

    def pairwise_data_set_enumerable
      @data_sets.combination(2)
    end

    def data_for!(data_set)
      unless data_set[:data]
        unless @file_data[data_set[:readable]]
          @file_data[data_set[:readable]] = data_set[:readable].read
        end
        data_set[:data] = @file_data[data_set[:readable]]
      end
      data_set[:data]
    end

    def calculate_a_score(data_set_1, data_set_2)
      data_set_1_data   = data_for!(data_set_1)
      data_set_2_data   = data_for!(data_set_2)
      sum_data = [data_set_1_data, data_set_2_data].join("\n")

      data_set_1_compressed_size = compressed_size_for(data_set_1_data)
      data_set_2_compressed_size = compressed_size_for(data_set_2_data)

      sum_of_compressed_sizes = data_set_1_compressed_size + data_set_2_compressed_size
      size_of_compressed_sum = compressed_size_for(sum_data)
      sum_of_compressed_sizes - size_of_compressed_sum
    end
  end
end


