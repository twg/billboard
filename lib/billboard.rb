require 'billboard/configuration'
require 'billboard/chart'
require 'mechanize'

module Billboard
  
  class Error < StandardError ; end
  
  class << self
    
    # Call this method to modify your configuration
    # Example:
    #   Billboard.configure do |config|
    #     config.login    = 'bob@example.com'
    #     config.password = '12345'
    #   end
    #
    def configure
      yield configuration
    end
    
    # Accessor for the Billboard::Configuration object
    # Example use:
    #   Billboard.config.login = 'bob@example.com'
    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration
  end
  
end