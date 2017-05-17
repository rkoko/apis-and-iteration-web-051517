#!/usr/bin/env ruby

require_relative "../lib/api_communicator_oo.rb"
require_relative "../lib/command_line_interface.rb"

welcome
character = get_character_from_user
char = Search.new(character)
char.films 
