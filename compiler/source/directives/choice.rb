# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information.
#

class Choice < Directive
  TAG = 'Directive::Choice'

  def initialize(parser, parent, token)
    super parser, parent, token
    @child = Scope.new(parser, self)
    @state = :choice
    @type = :choice
  end

  def state(token)
    raise SyntaxUnexpectedStateDirective.new TAG, @parser, self, [:end] if token != :END
    if @state != :choice
      Log.internal TAG, "Unexpected internal state value :#{@state} after receiving a '#{token}'"
    end
    @state = :end
  end

  def complete?
    return @state == :end
  end

  def append(token)
    if @state == :end
      raise ParsingError.new self, "unexpected block after END directive, expected new directive", token, position
    elsif @state == :choice
      @block.append token
    else
      Log.internal TAG, "Invalid internal state value of :#{@state}"
    end
  end

  def to_s
    return "CHOICE: #{@block}\n#{@child}END\n"
  end

  def validate(token)
    if @state == :choice
      raise ParsingError.new self, 'missing concluding END directive'
    elsif @state != :end
      Log.internal TAG, "Invalid internal state value of :#{@state}"
    end
  end
end

