require './weather'

begin
  asset = WeatherService.new
  printf "\n%-20s %s" , "City,State" , "Temperature"
  weather.get_woeids_from_file('woeid.txt').map { |id|  weather.request_web_service(id) }.sort.each do |key , value|
    printf  "\n%-20s %s" , key , value
  end
rescue => ex
  puts "\n Error: #{ex}"
end
