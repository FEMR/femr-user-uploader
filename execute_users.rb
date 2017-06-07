#!/usr/bin/env ruby

require 'open3'
require 'optparse'

options = {}
parser = OptionParser.new do |opts|
  opts.banner = "Usage: " + __FILE__ + " -e, --email <email> -p, --password <password> -f, --first-name <First Name> -l, --last-name <Last Name> -n, --notes <notes> -r, --roles <role list> -c, --cookie-file <cookie file> -i, --uri <fEMR URI>"
  #Set option for username
  opts.on("-e", "--email <email>", String, "User email") do |opt|
    options[:email] = opt
  end
  #Set option for user password
  opts.on("-p", "--password <pw>", String, "User password") do |opt|
    options[:password] = opt
  end
  #choose destination to store cookies
  opts.on("-f", "--first-name <First Name>", String, "User First name") do |opt|
    options[:firstname] = opt
  end
  #choose fEMR URI to hit
  opts.on("-l", "--last-name <Last Name>", String, "User Last name") do |opt|
    options[:lastname] = opt
  end
  opts.on("-n", "--notes <notes>", String, "Any notes about the user") do |opt|
    options[:notes] = opt
  end
  opts.on("-r", "--roles x,y,z", Array, "Comma separated list without spaces of roles") do |opt|
    options[:roles] = opt
  end
  opts.on("-c", "--cookie-file <Cookie File>", String, "File that has tha cookie") do |opt|
    options[:cookiefile] = opt
  end
  opts.on("-i", "--uri <fEMR URI>", String, "URI fEMR is running at") do |opt|
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

#Only required fields on this form are email, password, and first name
if (options[:email].nil?)
  raise OptionParser::MissingArgument, "No email provided"
end
if (options[:password].nil?)
  raise OptionParser::MissingArgument, "No password provided"
end  
if (options[:firstname].nil?)
  raise OptionParser::MissingArgument, "Need a first name"
end
if (options[:roles].nil?)
  raise OptionParser::MissingArgument, "Provide at least 1 role"
end
if (options[:cookiefile].nil?)
  raise OptionParser::MissingArgument, "Gimme a cookie file to work with"
end
if (options[:uri].nil?)
  raise OptionParser::MissingArgument, "NEED URI"
end

begin

  #Get rid  of the @ sign
  options[:email].sub!('@','%40')

  #Create curl string without the roles appended
  cmd = "curl --data \"email=#{options[:email]}&password=#{options[:password]}&passwordVerify=#{options[:password]}&firstName=#{options[:firstname]}&lastName=#{options[:lastname]}&notes=#{options[:notes]}"

  #Append the damn roles
  options[:roles].each { |role| cmd << "&roles%5B%5D=#{role}" }

  #Throw the final quote on the end
  cmd << "\""
  
  #Add the cookie file
  cmd << " --cookie #{options[:cookiefile]}"

  #Add the URI
  cmd << " #{options[:uri]}/admin/users/create"

  #puts cmd
  #??
  #profit
  Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
  #  puts "stdout is:" + stdout.read
  #  puts "stderr is:" + stderr.read
  end

end
