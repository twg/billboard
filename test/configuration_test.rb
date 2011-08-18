require File.expand_path('../helper', __FILE__)

class ConfigurationTest < Test::Unit::TestCase
  
  def test_initialization_defaults
    config = Billboard::Configuration.new
    assert_equal 'http://www.billboard.biz/bbbiz/login', config.login_url
    assert_equal nil, config.login
    assert_equal nil, config.password
    assert_equal '/tmp/billboard.cookie', config.cookie_path
  end
  
  def test_initialization_with_api_key
    login = 'test@test.test'
    Billboard.config.login = login
    assert_equal login, Billboard.config.login
  end
  
end
