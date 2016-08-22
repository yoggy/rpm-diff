#!/usr/bin/ruby
# -*- coding: euc-jp -*-
#
#  rpm-diff.rb - diff utility for rpm packages
#
#  https://github.com/yoggy/rpm-diff
#
#  license:
#      Copyright (c) 2016 yoggy <yoggy0@gmail.com>
#      Released under the MIT license
#      http://opensource.org/licenses/mit-license.php;
#
require 'json'
require 'pp'
require_relative 'package'

def usage
puts <<-EOS
usage : 
    #{$0} FILE1.txt FILE2.txt

example:
    $ sudo rpm -qa > rpm-list-1st.txt
    $ sudo yum update
    $ sudo yum install something
       .
       .
    (installed / removed / updated packages)
       .
       .
    $ sudo rpm -qa > rpm-list-2nd.txt
  
    $ ruby rpm-diff.rb rpm-list-1st.txt rpm-list-2nd.txt

  EOS
  exit
end

def parse_rpm_qa(list_str)
  return [] if list_str.nil?

  result = {}
  list_str.each_line do |l|
    l.chomp!
    pkg = Package.new(l)
    result[pkg.name] = pkg
  end
  
  result
end

def diff(pkgs_old, pkgs_new)
  res_keep      = []
  res_new       = []
  res_modify    = []
  res_remove    = []

  pkgs_new.keys.each do |k|
    unless pkgs_old.key?(k)
      res_new << pkgs_new[k]
    end
  end

  pkgs_old.keys.each do |k|
    if pkgs_new.key?(k)
      p_old = pkgs_old[k]
      p_new = pkgs_new[k]

      if p_old == p_new 
        res_keep << p_new
      else
        res_modify << p_new
      end
    elsif
      res_remove << pkgs_old[k]
    end
  end

  result = {
    "keep"   => res_keep.sort,
    "new"    => res_new.sort,
    "modify" => res_modify.sort,
    "remove" => res_remove}

  result
end

def main
  usage if ARGV.size < 2 

  rpms_old = parse_rpm_qa(open(ARGV[0]).read)
  rpms_new = parse_rpm_qa(open(ARGV[1]).read)
  result = diff(rpms_old, rpms_new)

  puts JSON.pretty_generate(result)
end

if __FILE__ == $0
  main
end

