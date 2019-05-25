module ApplicationHelper
class << self
  def convert_data(data)
    data = data.split(/\n/)
    res = {}
    # Time
    res['last_observation'] = data[0] + ' GMT'              # Date Time of the last observation
    data = data[1].split(' ')
    # station
    res['station'] = data[0]
    # decoding wind speed and direction
    arr = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]        # Array of directions
    dir = data[3].first(3).to_i
    dir = dir/45 + 0.5                                        # Converting degrees to direction
    dir = arr[(dir % 8)]
    if data[3].length == 7
      speed = data[3][3] + data[3][4]                         # Case where gust is not present
    else
      speed = data[3][6] + data[3][7]                         # case where gust is present
    end
    speed_miles = speed.to_i * 1.15078                        # converting wind speed in miles per hour
    res['wind'] = "#{dir} at #{speed_miles} mph (#{speed} knots)"
    # Temperature
    temp = data[6].split('/')
    if temp[0][0] == 'M'                                       # Case where temperature is negative
      temp = - temp[0][1..-1].to_i
    else
      temp = temp[0].to_i
    end
    temp_f = temp * 9 / 5 + 32
    res['temperature'] = "#{temp} C (#{temp_f} F)"
    res
  end
  end
end
