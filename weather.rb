require 'net/http'
require 'rexml/document'

class WeatherService

  def get_woeids_from_file (file_name)
    IO.readlines(file_name).map(&:chomp)
  end

  def request_web_service (woeid)
    url = "http://weather.yahooapis.com/forecastrss?w=#{URI.encode(woeid)}&u=f"
    parse_result woeid , Net::HTTP.get_response(URI.parse(url)).body
  end

  def parse_result (woeid , xml_output)
    doc = REXML::Document.new xml_output
    if !(doc.root.elements["channel/item/title"].text.eql?( "City not found"))
      xpath = doc.root.elements["channel/yweather:location"]
      region = [xpath.attributes["city"] , xpath.attributes["region"]].join(",")
      temp = doc.root.elements["channel/item/yweather:condition"].attributes["temp"]
      [region , temp]
    else
      [woeid , "City Not Found!"]
    end
  end

end

