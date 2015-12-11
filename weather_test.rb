require './weather'
require 'test/unit'

class WeatherServiceTest  < Test::Unit::TestCase

  def setup
    @weather = WeatherService.new
  end

  def test_canary
    assert true
  end

  def test_get_woeids_from_file_no_file_name
    assert_raise(Errno::ENOENT) {@weather.get_woeids_from_file('')}
  end

  def test_get_woeids_from_file_no_file_in_folder
    assert_raise(Errno::ENOENT) {@weather.get_woeids_from_file('no_such_file.txt')}
  end

  def test_get_woeids_from_file
    assert(@weather.get_woeids_from_file('woeid.txt'))
  end

  def test_invalid_id_to_web_service
    assert_equal("000000" , @weather.request_web_service('000000')[0])
  end

  def test_request_web_service
    assert_equal("Houston,TX" , @weather.request_web_service('2424766')[0])
  end

  def test_parse_result_invalid_xml
    assert_raise(NoMethodError , "Invalid XML") {@weather.parse_result("12345" , "<rs></rs>")}
  end

  def test_to_get_temperature
    assert(@weather.get_woeids_from_file('woeid.txt').map { |id|  @weather.request_web_service(id) }.sort)
  end

end