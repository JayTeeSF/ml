module Ml
  class TokenCompressor
    DEFAULT_STOP_WORD_FILE = "#{File.dirname(__FILE__)}/../../config/stop-words_english_3_en.txt"

    def initialize(options={})
      @stem_words = options[:stem_words] || []
      @stop_words = options[:stop_words] || default_stop_words
    end

   # FIXME: use lazy enumerators instead of array(s)
   def deflate(data, *args)
     results = data.split(/\s+/).map do |raw_token|
       #puts "raw_token: #{raw_token.inspect}"
       normal_token = normalize(raw_token)
       #puts "normal_token: #{normal_token.inspect}"
       filtered_normal_token = filter(normal_token)
       #puts "filtered_normal_token: #{filtered_normal_token.inspect}"
       filtered_normal_token
     end.flatten.compact.uniq
     #puts "results: #{results.inspect}"
     return results
   end

   def close
   end

   private

   def default_stop_words
     open(DEFAULT_STOP_WORD_FILE).read.split("\r\n")
   end

   def normalize(token)
     token.downcase
   end

   def filter(token)
     return nil if stop_word?(token)
     stem_words(token)
   end

   def stem_words(token)
     [token]
   end

   def stop_word?(token)
     @stop_words.include?(token)
   end

  end
end
