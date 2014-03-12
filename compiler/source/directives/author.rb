# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information.
#

class Author < Directive
  TAG = 'Directives::Author'

  def initialize(parser, parent, speaker)
    super parser, parent, speaker
    @type = :author
  end

  def to_s
    "AUTHOR: #{@block}\n"
  end

  def validate(token)
    if @block.empty?
      raise ParsingError.new self, 'missing block'
    end
  end
end

