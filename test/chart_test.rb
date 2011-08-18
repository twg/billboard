require File.expand_path('../helper', __FILE__)

class ChartTest < Test::Unit::TestCase
  
  def test_blah
    chart = Billboard::Chart.get_chart('http://www.billboard.biz/bbbiz/charts/currentalbum/the-billboard-200')
    p chart
  end
  
end