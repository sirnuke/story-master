#!/usr/bin/env ruby
#
# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information
#

require 'fileutils'
require 'getoptlong'

module Constants
  APP_NAME = 'StoryMaster Compiler'
  APP_VERSION = '0.0.1'

  SOURCE_DIRECTORY = '/source/'

  EXIT_SUCESS = 0
  EXIT_FAILURE = -1
  EXIT_CRITICAL = -2
end

Dir.chdir File.dirname(__FILE__) + Constants::SOURCE_DIRECTORY do
  require './logging'
  require './position'
  require './exceptions'

  require './block'
  require './directive'
  require './scope'

  require './tokenizer'
  require './parser'
end

def usage
  puts <<-EOS
Usage: #{$0} [options] file...

  -h  --help          Print this help statement
  -v  --version       Print version and license information
  -o  --output=file   Output to a specific file

Script requires at least one source filename to compile.  The compiled
Lua script is written to the same directory as the source unless the
--output argument is set.

0 is returned on success, negative number otherwise.

    EOS
  exit Constants::EXIT_SUCCESS
end

def version
  puts <<-EOS
#{Constants::APP_NAME} #{Constants::APP_VERSION}
    EOS
  exit Constants::EXIT_SUCCESS
end

def getopts
  opts = GetoptLong.new(
    [ '--help',     '-h', GetoptLong::NO_ARGUMENT ],
    [ '--version',  '-v', GetoptLong::NO_ARGUMENT ],
    [ '--output',   '-o', GetoptLong::REQUIRED_ARGUMENT ]
  )
  opts.quiet = true
  output = nil
  begin
    opts.each do |opt, arg|
      case opt
      when '--help'
        usage
      when '--version'
        version
      when '--output'
        output = arg
      else
        Log.internal 'GetOpts', "Unknown processed argument of #{opt} (#{arg})"
      end
    end
  rescue GetoptLong::Error
    Log.e 'GetOpts', "Error while processing arguments: #{opts.error_message}"
  end
  Log.e 'GetOpts', "Requires one input file" if ARGV.size > 1
  return ARGV.first, output
end

source, output = getopts
output = source + '.lua' if source and output.nil?

if source
  Log.i 'SM', "Processing #{source} -> #{output}"
else
  Log.i 'SM', "Processing $stdin -> $stdout"
end

