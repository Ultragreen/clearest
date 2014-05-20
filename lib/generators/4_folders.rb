module Clearest
  class FoldersGenerator < AbstractGenerator 
    def initialize(_options = {})
      super _options
      @options[:list_folder].each do |folder|
        fullpath = "#{@options[:target_path]}/#{@options[:project_name]}/#{folder}"
        FileUtils.mkdir_p fullpath
        puts "     #{'creating'.colorize(:light_green)} (folder)     #{fullpath}"
      end
    end
  end
end
