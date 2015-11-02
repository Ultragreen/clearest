module Clearest
  class FilesCopyGenerator < AbstractGenerator
    def initialize(_options = {})
      super _options
      @options[:list_folder].each do |folder|
        files = Dir.glob("#{@template_root}/#{folder}/*").reject {|file| (file =~ /.tpl$/ or File::directory? file) }
        files.each do |file|
          fullpath = "#{@options[:target_path]}/#{@options[:project_name]}/#{folder}"
          puts "     #{'copying'.colorize(:light_green)}  (file)       #{fullpath}/#{File.basename(file)}"
          FileUtils::copy file, fullpath
        end
      end
    end
  end
end
