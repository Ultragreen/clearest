module DmIsReflective::SqliteAdapterPatch
  def reflective_lookup_primitive primitive
    case primitive.upcase
    when 'INTEGER' ; Integer
    when 'REAL', 'NUMERIC', 'FLOAT'; Float
    when 'VARCHAR' ; String
    when 'TIMESTAMP' ; DateTime
    when 'BOOLEAN' ; Property::Boolean
    when 'TEXT' ; Property::Text
    else Property::Text
    end || super(primitive)
  end
end


module DmIsReflective::ClassMethod
  def to_source scope=nil

    <<-RUBY
class #{scope}::#{name} < #{superclass}
include DataMapper::Resource
#{
properties.map do |prop|
    hash = prop.options.dup
    hash.delete :scale if hash.include? :scale and hash[:scale].nil?
    "property :#{prop.name}, #{prop.class.name}, #{hash}"
end.join("\n")
}
end
RUBY
  end  
end

DataMapper::Adapters.const_get("SqliteAdapter").__send__(:include,
     DmIsReflective::SqliteAdapterPatch)
DataMapper::Model.append_extensions(DmIsReflective)
