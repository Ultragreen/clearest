module Clearest
  class AutoFixtures < AbstractGenerator
    
    FLOAT_MAX = 256
    INT_MAX = 256
    STRING_MAX_LENGTH = 100
    
    attr_reader :fixtures
    
    def initialize(_options = {})
      super(_options)
      generate
    end
    
    
    private
    def random_string(length=10)
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
      password = ''
      length.times { password << chars[rand(chars.size)] }
      password
    end
    
    
    def fp_rand(limit)
      fl = limit.floor
      rm = limit.remainder(fl)
      rand(fl) + rand(rm)
    end
    
    def ignore
    end
    
    def mapping(_options = { :field => 'default',:type => 'String', :length => STRING_MAX_LENGTH})
      type_map = { 'DateTime'  => DateTime.now,
        'String' => "#{random_string(_options[:length]-(_options[:field].size + 1))}_#{_options[:field]}",
        'Text' => "#{random_string(STRING_MAX_LENGTH- (_options[:field].size + 1))}_#{_options[:field]}",
        'Serial' => ignore,
        'Boolean' => true,
        'Float' => fp_rand(FLOAT_MAX), 
        'Decimal' => fp_rand(FLOAT_MAX),
        'Integer' => rand(INT_MAX)
      }
      return type_map[_options[:type]]
    end
    
    def generate
      @fixtures = Hash::new
      @@dm.fields(@options[:table_name]).each do |content|
        field,type,spec = content
        type = type.to_s.split('::').last
        length = (spec[:length])? spec[:length] : STRING_MAX_LENGTH
        fixture = mapping :type => type, :length => length, :field => field
        @fixtures[field] = {:type => type, :length => length, :value => fixture } unless fixture.nil?
      end
      @fixtures
    end
    
    public
    
    
    def get_value_for(_options = {})
      field = _options[:field]
      field_spec = @fixtures[field]
      return mapping :type => field_spec[:type], :length => field_spec[:length], :field => field
    end
    
    def get_field(_options = { :type => ['String','Integer','Text','Float'] })
      @test_map = Hash::new
      @fixtures.each {|item,content| @test_map[item] = content[:type] } 
      _options[:type].each do |type|
        res = @test_map.rassoc type
        return res unless res.nil? 
      end
      return false
    end
    
    def to_s
      res = "{\n"
      records = Array::new
      @fixtures.each do |field,content|
        if ['Float','Decimal','Integer'].include? content[:type] then
          records << "     :#{field} => #{content[:value]}"
        else
          records << "     :#{field} => \"#{content[:value]}\""
        end
      end
      res << records.join(",\n")
      res << "\n   }\n"
    end
  end
end
