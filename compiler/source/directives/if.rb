# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information.
#

class If < Directive
  TAG = 'Directive::If'

  def initialize(parser, parent, token)
    super parser, parent, token
    @branches = []
    @block = nil
    @type = :if
    self.push_if
  end

  def child
    Log.internal TAG, "IF directive complete, can't return a child" if @state == :end
    @branches.last[:scope]
  end

  def push_if
    @state = :if
    @branches << { :type => :if, :block => Block.new, :scope => Scope.new(parser, self) }
  end

  def push_elseif
    @state = :elseif
    @branches << { :type => :elseif, :block => Block.new, :scope => Scope.new(parser, self) }
  end

  def push_else
    @state = :else
    @branches << { :type => :else, :block => nil, :scope => Scope.new(parser, self) }
  end

  def push_end
    @state = :end
  end

  def state(token)
    # TODO: Confirm current block isn't empty
    if @branches.first[:block].empty?
      raise ParsingError.new self, "expected block after #{@branches.first[:type].upcase} directive", token, position
    end
    case @state
    when :if
      if token == :ELSEIF
        push_elseif
      elsif token == :ELSE
        push_else
      elsif token == :END
        push_end
      else
        raise SyntaxUnexpectedStateDirective.new TAG, @parser, self, [:elseif, :else, :end]
      end
    when :elseif
      if token == :ELSEIF
        push_elseif
      elsif token == :ELSE
        push_else
      elsif token == :END
        push_end
      else
        raise SyntaxUnexpectedStateDirective.new TAG, @parser, self, [:elseif, :else, :end]
      end
    when :else
      if token == :END
        push_end
      else
        raise SyntaxUnexpectedStateDirective.new TAG, @parser, self, [:end]
      end
    else
      Log.internal TAG, "Unexpected internal state value :#{@state} after receiving a '#{token}'"
    end
  end

  def complete?
    return @state == :end
  end

  def append(token)
    if @state == :if || @state == :elseif
      @branches.last[:block].append token
    elsif @state == :end
      raise ParsingError.new self, "unexpected block after END directive, expected new directive", token, position
    elsif @state == :else
      raise ParsingError.new self, "unexpected block after ELSE directive, expected new directive", token, position
    else
      Log.internal TAG, "Invalid internal state value of :#{@state}"
    end
  end

  def to_s
    res = ''
    @branches.each do |branch|
      case branch[:type]
      when :if
        res += "IF: #{branch[:block]}\n#{branch[:scope]}"
      when :elseif
        res += "ELSEIF: #{branch[:block]}\n#{branch[:scope]}"
      when :else
        res += "ELSE\n#{branch[:scope]}"
      else
        Log.internal TAG, "Invalid branch type of :#{branch[:type]}"
      end
    end
    res += "END\n"
    return res
  end

  def validate(token)
    if @state == :if || @state == :elseif || @state == :else
      raise ParsingError.new self, 'missing concluding END directive'
    elsif @state != :end
      Log.internal TAG, "Invalid internal state value of :#{@state}"
    end
  end
end

