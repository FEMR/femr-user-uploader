#!/usr/bin/env ruby

require 'open3'
require 'optparse'

options = {}
parser = OptionParser.new do |opts|
  opts.banner = "Usage: " + __FILE__ + " -f, --file <file>"
  #choose destination to store cookies
  opts.on("-f", "--file <file>", String, "Cookie file to delete") do |opt|
    options[:file] = opt
  end
  #Option for help
  opts.on_tail('-h', '--help', 'Displays Help') do 
    print opts
    exit
  end
  ARGV.push('-h') if ARGV.empty?
end


parser.parse!

if (options[:file].nil?)
  raise OptionParser::MissingArgument, "Where do i put the cookies?"
end

begin

  cmd = "rm #{options[:file]}"
  Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
#    puts "stdout is:" + stdout.read
 #   puts "stderr is:" + stderr.read
  end

end
