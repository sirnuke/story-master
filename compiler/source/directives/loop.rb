# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information.
#

class Loop < Directive
  TAG = 'Directive::Loop'

  def initialize(parser, parent, token)
    super parser, parent, token
    @child = Scope.new(parser, self)
    @type = case token
    when 'LOOP'
      :loop
    when 'UNTIL'
      :until
    when 'WHILE'
      :while
    when 'FOR'
      :for
    else
      Log.internal TAG, "Invalid loop type on token #{token}"
    end
    @state = :loop
  end

  def state(token)
    if token != :END
      raise ParsingError.new self, 'invalid state directive, expected END', token, position
    end
    if @state != :loop
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
    elsif @state == :loop
      if @type == :loop
        raise ParsingError.new self, "unexpected block after LOOP directive, expected new directive", token, position
      end
      @block.append token
    else
      Log.internal TAG, "Invalid internal state value of :#{@state}"
    end
  end

  def to_s
    result = case @type
    when :loop
      'LOOP'
    when :until
      "UNTIL: #{@block}"
    when :while
      "WHILE: #{@block}"
    when :for
      "FOR: #{@block}"
    else
      Log.internal TAG, "Invalid loop type of :#{@type}"
    end
    result += "\n#{@child}END\n"
    return result
  end

  def validate(token)
    if @state == :loop
      raise ParsingError.new self, 'missing concluding END directive'
    elsif @state != :end
      Log.internal TAG, "Invalid internal state value of :#{@state}"
    end
  end
end

