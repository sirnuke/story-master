# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information.
#

class Dialog < Directive
  attr_reader :speaker
  TAG = 'Directive::Dialog'

  def initialize(parser, parent, speaker)
    super parser, parent, speaker
    @speaker = speaker
    @type = :dialog
  end

  def validate(token)
    if @block.empty?
      raise SyntaxMissingBlockError.new TAG, self
    end
  end

  def write_lua(out, tab)
    out.puts "#{Constants::BASE_INDENT * tab}dialog('#{@speaker}', '#{@block}')"
  end

  def to_s
    "#{@speaker}: #{@block}\n"
  end
end

