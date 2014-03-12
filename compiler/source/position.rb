# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information
#

class Position
  attr_reader :filename, :line, :character, :raw
  attr_accessor :eof

  def initialize(filename, line=0, character=0)
    @filename = filename
    @line = line
    @character = character
    @raw = nil
    @eof = false
  end

  def next(character = 0)
    @line += 1
    @character = character
    @raw = nil
  end

  def token
    @raw.strip
  end

  def increment(raw_token)
    @character += @raw.length unless @raw.nil?
    @raw = raw_token
  end

  def to_s
    if @eof
      "#{@filename}@EOF"
    elsif @token.nil?
      "#{@filename}@#{@line}"
    else
      "#{@filename}@#{@line}:#{@character} on '#{@token}'"
    end
  end
end

