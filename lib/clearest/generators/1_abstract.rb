module Clearest
  class AbstractGenerator
    def initialize(_options = {})
      @options = _options
      @@dm ||= DataMapper.setup(:default, _options[:dsn])
      @options[:list_folder] = Dir.glob("template/**/").each do |folder|folder.gsub! 'template/','' end
      @options[:list_folder].reject! {|item| item.empty? }
      @options[:list_folder].push "."
      @options[:prefix] ||= '/api'
    end
  end
end
