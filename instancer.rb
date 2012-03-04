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
  write(file, list << ip)
end

def remove(file, ip)
  list = read(file)
  write(file, list.delete_if { |entry| entry == ip })
end

get /.*favicon.*/ do
  ""
end

get /\/(.*)/ do |type|
  read(type + DATA_FILE_SUFIX).join(",")
end

post /\/(.*)/ do |type|
  add(type + DATA_FILE_SUFIX, params[:ip])
  ""
end

delete /\/(.*)/ do |type|
  remove(type + DATA_FILE_SUFIX, params[:ip])
  ""
end
