require 'yaml'
module Clearest
  module Validators
    module Applications
      def Applications::check(_options = {})
        conf = YAML.load_file('application.yml')
      end
    end
  end
end
