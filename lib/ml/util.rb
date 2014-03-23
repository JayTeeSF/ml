module Ml
  module Util
    extend self

    def load_gem(name, as=name, version=nil)
      # needed if your ruby version is less than 1.9
      #require 'rubygems'

      begin
        gem name, version
      rescue LoadError
        version = "--version '#{version}'" unless version.nil?
        system("gem install #{name} #{version} --no-ri --no-rdoc")
        Gem.clear_paths
        retry
      end

      require as
    end
  end
end
