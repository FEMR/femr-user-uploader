#!/usr/bin/env ruby

require 'open3'
require 'optparse'

options = {}
parser = OptionParser.new do |opts|
  opts.banner = "Usage: " + __FILE__ + " -u, --username <username> -p, --password <password> -f, --file <file> -i, --uri <fEMR URI>"
  #Set option for username
  opts.on("-u", "--username <username>", String, "Login username") do |opt|
    options[:username] = opt
  end
  #Set option for user password
  opts.on("-p", "--password <pw>", String, "Login password") do |opt|
    options[:password] = opt
  end
  #choose destination to store cookies
  opts.on("-f", "--file <file>", String, "File to maintain cookies") do |opt|
    options[:file] = opt
  end
  #choose fEMR URI to hit
  opts.on("-i", "--uri <URI>", String, "URI for target fEMR") do |opt|
    options[:uri] = opt
  end
  #Option for help
  opts.on_tail('-h', '--help', 'Displays Help') do 
    print opts
    exit
  end
  ARGV.push('-h') if ARGV.empty?
end
parser.parse!

if (options[:username].nil?)
  raise OptionParser::MissingArgument, "No username provided"
end
if (options[:password].nil?)
  raise OptionParser::MissingArgument, "No password provided"
end  
if (options[:file].nil?)
  raise OptionParser::MissingArgument, "Where do i put the cookies?"
end
if (options[:uri].nil?)
  raise OptionParser::MissingArgument, "Where is fEMR?"
end

begin
  
  cmd = "curl --data \"email=#{options[:username]}&password=#{options[:password]}\" --cookie-jar #{options[:file]} #{options[:uri]}/login"
  
  Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
    #puts "stdout is:" + stdout.read
    #puts "stderr is:" + stderr.read
  end

end
