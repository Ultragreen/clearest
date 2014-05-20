module Clearest
  class TemplatesGenerator < AbstractGenerator
    def initialize(_options = {})
      super _options
      template_base = './template/'
      fullpath = "#{@options[:target_path]}/#{@options[:project_name]}"
      @options[:model_name] = DataMapper::Inflector.singularize _options[:table_name].capitalize
      @options[:test_db_filename] ||= '/tmp/clearest.db'
      @options[:template_map].each do |template,list|
        file_target = template.sub 'TABLE_NAME', @options[:table_name]
        generator = Template::new :list_token => list, :template_file => "#{template_base}#{template}.tpl"
        _data = @options.dup
        _data.each {|item,value| _data.delete item unless list.include? item.to_sym}
        if template == 'models/TABLE_NAME.rb' then
          models = @@dm.auto_genclass! :storages => @options[:table_name], :scope => Object
          _data[:model_definition] = models.first.to_source
        end
        fixtures = AutoFixtures::new(_options)
        if template == 'spec/TABLE_NAME_spec.rb' then
          [:first_obj,:second_obj].each do |obj|
            _data[obj] = fixtures.to_s
          end
          field,type = fixtures.get_field
          new_fixture = fixtures.get_value_for :field => field
          _data[:updated_field] = ":#{field.to_s}"
          if ['Float','Decimal','Integer'].include? type then
            _data[:new_value] = "#{new_fixture}"
          else
            _data[:new_value] = "'#{new_fixture}'"
          end
        end
        generator.map _data
        puts "     #{'staging'.colorize(:light_green)}  (template)   #{fullpath}/#{file_target}"
        File.open("#{fullpath}/#{file_target}", 'w') { |file| file.write(generator.output) }
      end
    end
  end
end
