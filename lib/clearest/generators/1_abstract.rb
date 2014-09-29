module Clearest
  class AbstractGenerator
    def initialize(_options = {})
      @options = _options
      @template_root = File.expand_path("../../../template", __FILE__)
      @@dm ||= DataMapper.setup(:default, _options[:dsn])
      @options[:list_folder] = Dir.glob("#{@template_root}/*").reject {|folder| (File::file? folder) }.map {|folder| folder.split('/').last }
      @options[:list_folder] << '.'
      @options[:prefix] ||= '/api'
    end
  end
end
