# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information.
#

class Scene < Directive
  TAG = 'Directive::Scene'

  def initialize(parser, parent, speaker)
    super parser, parent, speaker
    @type = :scene
  end

  def to_s
    "SCENE: #{@block}\n"
  end

  def validate(token)
    if @block.empty?
      raise SyntaxMissingBlockError.new TAG, self
    end
  end

end

