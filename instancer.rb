require 'sinatra'

DATA_FILE_SUFIX = ".dat"

def read(file)
  list = []
  File.open(file, "r") do |file|
    file.each_line { |line| list << line unless line.strip!.empty? }
  end
  list
end

def write(file, list)
  File.open(file, "w") do |file|
    list.each { |entry| file.puts entry }
  end  
end

def add(file, ip)
  list = read(file)
  write(file, (list << ip).uniq)
end

def remove(file, ip)
  list = read(file)
  write(file, list.delete_if { |entry| entry == ip })
end

get /.*favicon.*/ do
  ""
end

get /\/(\w+)/ do |type|
  read(type + DATA_FILE_SUFIX).join(",")
end

post /\/(\w+)/ do |type|
  add(type + DATA_FILE_SUFIX, params[:ip])
  ""
end

delete /\/(\w+)/ do |type|
  remove(type + DATA_FILE_SUFIX, params[:ip])
  ""
end

DB_PREFIX='db'
APP_PREFIX='app'

get '/' do 
    puts "db servers :", read(DB_PREFIX+DATA_FILE_SUFIX)
    puts "app servers:", read(APP_PREFIX+DATA_FILE_SUFIX)
   #"Welcome to "
   @instances = {
        'oracle_db'=>"192.168.56.2", 
        'app_honnix'=>"192.168.56.3", 
        'app_larry'=>"192.168.56.4",
        'app_liren'=>"192.168.56.5",
        'ha_proxy'=>"192.168.56.6"
        
   }
   erb :index
end