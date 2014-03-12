# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information.
#

class Identifier < Directive
  TAG = "Directive::Identifier"

  def initialize(parser, parent, speaker)
    super parser, parent, speaker
    @type = :identifier
  end

  def to_s
    "IDENTIFIER: #{@block}\n"
  end

  def append(token)
    unless @block.empty?
      raise SyntaxInvalidIdentifierError.new TAG, self
    end
    @block.append token
  end

  def validate(token)
    if @block.empty?
      raise SyntaxInvalidIdentifierError.new TAG, self
    end
  end
end

