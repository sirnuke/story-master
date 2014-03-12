# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information
#

class Block
  def initialize
    @data = ''
  end

  def append(token)
    @data += ' ' unless @data.empty?
    @data += token
  end

  def keyword?
    if @data.empty? or not @data.index /\s/
      false
    else
      true
    end
  end

  def empty?
    @data.empty?
  end

  def to_s
    @data
  end
end

