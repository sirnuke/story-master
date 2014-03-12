# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information.
#

class StoryDate < Directive
  TAG = 'Directives::Date'

  def initialize(parser, parent, speaker)
    super parser, parent, speaker
    @type = :date
  end

  def to_s
    "DATE: #{@block}\n"
  end

  def validate(token)
    if @block.empty?
      raise ParsingError.new self, 'missing block'
    end
  end
end

