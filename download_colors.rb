#!/usr/bin/env ruby

require 'net/http'
require 'json'

color_dict_js = Net::HTTP.get(URI('http://developer.getpebble.com/assets/js/tools/color-dict.js'))
sunlight_map_js = Net::HTTP.get(URI('http://developer.getpebble.com/assets/js/tools/color-mapping-sunlight.js'))

color_dict_data = JSON.parse(color_dict_js[/\{.*\}/m])
sunlight_map_data = JSON.parse(sunlight_map_js[/\{.*\}/m])

data = color_dict_data.map do |key, val|
  puts key
  puts sunlight_map_data
  sun_red, sun_green, sun_blue = [1..2, 3..4, 5..6].map do |index_range|
    sunlight_map_data[key.downcase][index_range].to_i(16)
  end
  {
    name: val['name'],
    red: val['r'],
    green: val['g'],
    blue: val['b'],
    sunlight_red: sun_red,
    sunlight_green: sun_green,
    sunlight_blue: sun_blue
  }
end

puts JSON.dump(data)
