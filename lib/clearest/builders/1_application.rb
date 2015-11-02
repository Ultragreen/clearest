module Clearest
  class ApplicationBuilder
    def initialize(_options = {})
      _options[:template_map] = {
        'main.rb' => [:dsn]
      }
      Clearest::FoldersGenerator::new _options
      Clearest::FilesCopyGenerator::new _options
      Clearest::TemplatesGenerator::new _options
      File.open("#{_options[:target_path]}/#{_options[:project_name]}/application.yml", 'w') {|f| f.write _options.to_yaml } 
    end
  end
end
