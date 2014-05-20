module Clearest
  class ServiceBuilder
    def initialize(_options = {})
      _options[:template_map] = {
        'models/TABLE_NAME.rb' => [:model_definition],
        'routes/TABLE_NAME.rb' => [:prefix,:table_name,:model_name],
        'spec/TABLE_NAME_spec.rb' => [:prefix,:table_name,:model_name,:test_db_filename,:first_obj,:second_obj,:updated_field,:new_value]
      }
      Clearest::TemplatesGenerator::new _options
    end
  end
end
