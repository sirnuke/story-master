# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information
#

class Log
  def self.error(tag, message)
    output 'E', tag, message
    exit Constants::EXIT_FAILURE
  end

  def self.warn(tag, message)
    output 'W', tag, message
  end

  def self.info(tag, message)
    output 'I', tag, message
  end

  def self.debug(tag, message)
    output 'D', tag, message
  end

  def self.verbose(tag, message)
    output 'V', tag, message
  end

  def self.internal(tag, message)
    output '!', tag, message
    exit Constants::EXIT_CRITICAL
  end

  class << self
    alias e error
    alias w warn
    alias i info
    alias d debug
    alias v verbose
  end

  private

  def self.output(level, tag, message)
    $stderr.puts "[#{level}][#{tag}]: #{message}"
  end
end

