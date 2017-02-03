#gem install net-ping
#run script as root
#sudo ruby ping_tool.rb 8.8.8.8

require 'net/ping'

module Enumerable

  def sum
    self.inject(0){|accum, i| accum + i }
  end

  def mean
    self.sum/self.length.to_f
  end

  def sample_variance
    m = self.mean
    sum = self.inject(0){|accum, i| accum +(i-m)**2 }
    sum/(self.length - 1).to_f
  end

  def standard_deviation
    return Math.sqrt(self.sample_variance)
  end

end

host = ARGV[0]

icmp = Net::Ping::ICMP.new(host)
ping_array = []
math_array = []
pingfails = 0
repeat = 50

(1..repeat).each do
  if icmp.ping
    ping_ms = (icmp.duration * 1000).round(3)
    math_array << ping_ms
    ping_array << [Time.now.strftime("%m/%e/%y %H:%M:%S"), ping_ms]

    print "#{ping_ms} ms".ljust(13, " ")

    ping_int = ping_ms.to_i/10
    puts "".ljust(ping_int,".")

    sleep(1)
  else
    pingfails += 1
    puts "timeout"
  end
end

received = repeat - pingfails
loss = ((pingfails / repeat)*100).round(1)

avg = math_array.mean.round(3)
min = math_array.min.round(3)
max = math_array.max.round(3)
stdev = math_array.standard_deviation.round(3)

puts "#{repeat} packets transmitted, #{received} received, #{loss}% packet loss"
puts "round-trip min/avg/max/stddev = #{min}/#{avg}/#{max}/#{stdev} ms"

puts "".ljust(5,"\n")
ping_array.each do |time, ping|
  puts "#{time},#{ping}"
end