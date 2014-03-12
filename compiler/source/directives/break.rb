# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information.
#

class Break < Directive
  TAG = 'Directive::Break'

  def initialize(parser, parent, speaker)
    super parser, parent, speaker
    @type = :break
  end

  def to_s
    "BREAK\n"
  end

  def append(token)
    raise ParsingError.new self, 'unexpected block'
  end

  def validate(token)
    unless @block.empty?
      Log.internal TAG, "BREAK doesn't have a block, should have already been caught"
    end
  end
end

