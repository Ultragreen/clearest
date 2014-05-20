ENV['RACK_ENV'] = 'test'

require './main'  
require './spec/spec_helper.rb'


describe '%%MODEL_NAME%% REST CRUD API' do
  before :all do 
    base_file = '%%TEST_DB_FILENAME%%'
    File::unlink(base_file) if File::exist?(base_file)
    DataMapper.auto_migrate!
    $service  = RestCRUDService::new :object => '%%TABLE_NAME%%'
    $first_obj = %%FIRST_OBJ%%
    $second_obj = %%SECOND_OBJ%%
  end

  subject { $service } 
  context "POST %%PREFIX%%/%%TABLE_NAME%% : create a new record" do
    it { subject.create_record($first_obj).should be_correctly_sent }
    it { subject.should respond_with_status 201 } 
  end
  
  context "POST %%PREFIX%%/%%TABLE_NAME%% : create an other record" do 
    it { subject.create_record($second_obj).should be_correctly_sent }
    it { subject.should respond_with_status 201 }
  end
    
  context "GET %%PREFIX%%/%%TABLE_NAME%% : retrieve all records" do 
    before do
      $first_obj[:id] = 1
      $second_obj[:id] = 2
    end
    it { subject.retrieve_all_records.should be_correctly_sent }
    it { subject.should respond_with_status 200 }    
    it { subject.should respond_a_collection_of_record }
    it { subject.should respond_with_data [$first_obj,$second_obj] }
    it { subject.should respond_with_collection_size 2 }
  end
  
  context 'GET %%PREFIX%%/%%TABLE_NAME%%/2 : retrieve the second record' do 
    it { subject.retrieve_record(2).should be_correctly_sent }
    it { subject.should respond_with_status 200 }
    it { subject.should respond_a_record }
    it { subject.should respond_with_data $second_obj }
  end

  context 'PUT %%PREFIX%%/%%TABLE_NAME%%/2 : update the second record ' do 
    it { subject.update_record(2,{ %%UPDATED_FIELD%% => %%NEW_VALUE%%}).should be_correctly_sent }
    it { subject.should respond_with_status 200 }
  end
  
  context 'DELETE %%PREFIX%%/%%TABLE_NAME%%/1 : delete the first record ' do 
    it { subject.destroy_record(1).should be_correctly_sent }
    it { subject.should respond_with_status 200 }
  end
  
  context 'GET %%PREFIX%%/%%TABLE_NAME%% : retrieve all records ' do 
    before do 
      # todo mod record for first not default string field
      $second_obj[%%UPDATED_FIELD%%] = %%NEW_VALUE%%
    end
    it { subject.retrieve_all_records.should be_correctly_sent }
    it { subject.should respond_with_status 200 }
    it { subject.should respond_a_collection_of_record }
    it { subject.should respond_with_collection_size 1 }
    it { subject.should respond_with_data $second_obj }
  end

  context 'GET %%PREFIX%%/%%TABLE_NAME%%/1 : failed to retrieve the first record' do 
    it { subject.retrieve_record(1).should be_correctly_sent }
    it { subject.should respond_with_status 404 }
    it { subject.should_not respond_with_data $first_obj }
  end

  context 'GET %%PREFIX%%/%%TABLE_NAME%%/2 : retrieve the second record' do 
    it { subject.retrieve_record(2).should be_correctly_sent }
    it { subject.should respond_with_status 200 }
    it { subject.should respond_a_record }
    it { subject.should respond_with_data $second_obj}
  end

end
