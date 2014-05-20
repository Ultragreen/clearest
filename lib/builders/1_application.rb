module Clearest
  class ApplicationBuilder
    def initialize(_options = {})
      _options[:template_map] = {
        'main.rb' => [:dsn]
      }
      Clearest::FoldersGenerator::new _options
      Clearest::FilesCopyGenerator::new _options
      Clearest::TemplatesGenerator::new _options
    end
  end
end
