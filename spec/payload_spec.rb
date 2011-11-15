require File.expand_path('../helper', __FILE__)

describe Redtail::Payload do
  
  before do

  end
  
  it 'formats a params hash for the message' do
    payload = Redtail::Payload.new(:params => {
      :foo => 'blah',
      :bar => 'halb',
      :foobar => 'blahhalb'
    })
    
    payload.formatted_params.must_equal " foo     => blah\n bar     => halb\n foobar  => blahhalb\n"
  end
  
  it 'formats the metadata hash for the message' do
    payload = Redtail::Payload.new(
      :project_root => '/home/redtail',
      :url => '/foo/bar',
      :hostname => 'localhost',
      :component => 'a_controller',
      :action => 'an_action'
    )
    
    payload.formatted_metadata.must_equal " project_root  => /home/redtail\n hostname      => localhost\n url           => /foo/bar\n component     => a_controller\n action        => an_action\n"
  end
  
  
end
