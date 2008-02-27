# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/name_parser.rb'

Hoe.new('name_parser', NameParser::VERSION) do |p|
  p.rubyforge_name = 'name_parser'
  p.author = 'Brian Cooke'
  p.email = 'brian.cooke@makalumedia.com'
  p.summary = 'Parse a given string into parts of a name'
  p.description = p.paragraphs_of('README.txt', 2..5).join("\n\n")
  p.url = p.paragraphs_of('README.txt', 0).first.split(/\n/)[1..-1]
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
end

# vim: syntax=Ruby
