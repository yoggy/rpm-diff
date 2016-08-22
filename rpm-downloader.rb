#!/usr/bin/ruby
require 'json'
require 'fileutils'
require 'pp'
require_relative 'package'

Dir.chdir(File.dirname($0))

json = JSON.parse(ARGF.read)

pkgs = []

json["new"].each do |str|
  pkgs << Package.new(str)
end

json["modify"].each do |str|
  pkgs << Package.new(str)
end

pkgs.sort!

FileUtils.mkdir_p("./rpms/")

pp pkgs

pkgs.each do |p|
  cmd = "yumdownloader --destdir=./rpms/ #{p.name}"
  puts "exec : cmd=#{cmd}"
  system(cmd)
end
