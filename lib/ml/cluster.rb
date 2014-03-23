module Ml
  class Cluster
    def self.score(files, options={})
      new(files,options).score
    end

    def initialize(files, options={})
      @files = files
      @compressor = options[:compressor] || Zlib::Deflate.new #(Zlib::BEST_COMPRESSION)
      @compressor_args = options[:compressor_args] || Zlib::FULL_FLUSH
    end

    def score
      results = pairwise_file_enumerable.map {|f1,f2|
        f1_data   = open(f1).read
        f2_data   = open(f2).read
        sum_data = [f1_data, f2_data].join("\n")

        f1_size   = @compressor.deflate(f1_data,   @compressor_args).size
        f2_size   = @compressor.deflate(f2_data,   @compressor_args).size
        sum_of_compressed_sizes = f1_size + f2_size

        size_of_compressed_sum = @compressor.deflate(sum_data, @compressor_args).size

        {:files => [f1, f2], :score => sum_of_compressed_sizes - size_of_compressed_sum }
      }
      results.sort {|a,b| b[:score] <=> a[:score]}
    end

    private

    def pairwise_file_enumerable
      @files.combination(2)
    end
  end
end


