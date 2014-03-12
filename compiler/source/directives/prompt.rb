# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information.
#

class Prompt < Directive
  TAG = 'Directive::Prompt'

  def initialize(parser, parent, token)
    super parser, parent, token
    @child = Scope.new(parser, self)
    @state = :prompt
    @type = :project
  end

  def state(token)
    if token != :ASK
      raise ParsingError.new self, 'invalid state directive, expected ASK', token, position
    end
    if @state != :prompt
      Log.internal TAG, "Unexpected internal state value :#{@state} after receiving a '#{token}'"
    end
    @state = :ask
  end

  def complete?
    return @state == :ask
  end

  def append(token)
    if @state == :ask
      raise ParsingError.new self, "unexpected block after ASK directive, expected new directive", token, position
    elsif @state == :prompt
      @block.append token
    else
      Log.internal TAG, "Invalid internal state value of :#{@state}"
    end
  end

  def to_s
    if @block.empty?
      "PROMPT\n#{@child}ASK\n"
    else
      "PROMPT: #{@block}\n#{@child}ASK\n"
    end
  end

  def validate(token)
    if @state == :prompt
      raise ParsingError.new self, 'missing concluding ASK directive'
    elsif @state != :ask
      Log.internal TAG, "Invalid internal state value of :#{@state}"
    end
  end
end

