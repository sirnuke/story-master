# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information.
#

class Project < Directive
  TAG = 'Directive::Project'

  def initialize(parser, parent, speaker)
    super parser, parent, speaker
    @type = :project
  end

  def to_s
    "PROJECT: #{@block}\n"
  end

  def validate(token)
    if @block.empty?
      raise ParsingError.new self, 'missing block'
    end
  end
end

