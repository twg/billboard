module Billboard
  
  class Configuration
    
    # Login URL for billboard.biz. At the moment it's http://www.billboard.biz/bbbiz/login
    attr_accessor :login_url
    
    # Account login
    attr_accessor :login
    
    # Account password
    attr_accessor :password
    
    # Location where session cookie is stored. Default is /tmp/billboard.cookie
    attr_accessor :cookie_path
    
    def initialize
      @login_url    = 'http://www.billboard.biz/bbbiz/login'
      @login        = nil
      @password     = nil
      @cookie_path  = '/tmp/billboard.cookie'
    end
  end
end