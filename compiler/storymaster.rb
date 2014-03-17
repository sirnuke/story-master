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
  VERSION_MAJOR = 0
  VERSION_MINOR = 0
  VERSION_PATCH = 1
  APP_VERSION = "#{VERSION_MAJOR}.#{VERSION_MINOR}.#{VERSION_PATCH}"

  SOURCE_DIRECTORY = '/source/'

  EXIT_SUCCESS = 0
  EXIT_FAILURE = -1
  EXIT_CRITICAL = -2

  BASE_INDENT = '  '
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
  -n  --name=name     Manually set the scene name
  -o  --output=file   Output to a specific file

Script requires at least one source filename to compile.  The generated
Lua script is written to stdout when input is read from stdin, or the
same directory as the source overridden by the --output argument.

Name is parsed from the filename, minus '.scene' and various symbols
replaced with an underscore.  This must be manually set when reading
from stdin.

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
    [ '--name',     '-n', GetoptLong::REQUIRED_ARGUMENT ],
    [ '--output',   '-o', GetoptLong::REQUIRED_ARGUMENT ],
  )
  opts.quiet = true
  name = nil
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
      when '--name'
        name = arg
      else
        Log.internal 'GetOpts', "Unknown processed argument of #{opt} (#{arg})"
      end
    end
  rescue GetoptLong::Error
    Log.e 'GetOpts', "Error while processing arguments: #{opts.error_message}"
  end
  Log.e 'GetOpts', "Requires one input file" if ARGV.size > 1
  return ARGV.first, name, output
end

source, name, output = getopts

Log.e 'GetOpts', "Must set name with --name when reading from stdin" unless source or name

if source 
  name = File.basename(source, '.scene') unless name
  name.gsub!(/\W/, '_')
  unless output
    output = File.dirname(source) + '/' + File.basename(source, '.scene') + '.lua'
  end
end

if source
  Log.i 'SM', "Processing #{source} -> #{output}"
  parser = Parser.file(name, source)
else
  Log.i 'SM', "Processing $stdin -> $stdout"
  parser = Parser.stdin(name)
end

parser.parse
puts parser

if output
  File.open(output, 'w') do |f|
    parser.write_lua f
  end
else
  parser.write_lua $stdout
end


