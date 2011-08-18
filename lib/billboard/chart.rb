module Billboard
  module Chart
    class << self
      
      # returns a chart in array form
      def get_chart(url)
        page = get_page(url)
        
        result = []
        table = page.search('table.bodyContent').first
        table.search('tr').each do |row|
          cells = row.search('td')
          if (data_cell = (cells.size == 6 ? cells[4] : cells[3]))
            data = data_cell.search('font')[1].inner_html
              #.gsub(/\t|\r|\n|\s{2,}/, '')
              #.gsub('&amp;', '&')
              #.strip
              # .match(Regexp.new("<b>([^\u00A0]+)"))[1].chop
            result << data.split(',')
          end
        end
        result
      end
      
      # Getting the page object. If login page is loaded, will trigger a login.
      # After 2 attempts to get proper page it will fail
      def get_page(url, attempt = 0)
        page = agent.get(url)
        if page.uri.to_s == Billboard.config.login_url
          raise Billboard::Error, "Cannot load page with URL: #{page.uri}" if attempt > 1
          login(attempt == 1)
          page = get_page(url, attempt += 1)
        end
        page
      end
      
      # Attempting to create a session. Reusing exsting cookie if possible
      # Forcing it will skip cookie load and will proceed with form login
      def login(force = false)
        if File.exists?(Billboard.config.cookie_path) && !force
          puts 'LOGGING IN VIA COOKIE'
          agent.cookie_jar.load(Billboard.config.cookie_path)
        else
          puts 'LOGGING IN VIA FORM'
          unless Billboard.config.login && Billboard.config.password
            raise Billboard::Error, 'Login and/or Password are not set'
          end
          
          page = agent.get('http://www.billboard.biz/bbbiz/login')
          form = page.form_with(:name => 'login')
          form.login    = Billboard.config.login
          form.password = Billboard.config.password
          page = form.submit
          if page.uri.to_s != Billboard.config.login_url
            agent.cookie_jar.save_as(Billboard.config.cookie_path)
          end
        end
      end
      
      # Mechanize agent object
      def agent
        @agent ||= Mechanize.new
      end
      
    end
  end
end