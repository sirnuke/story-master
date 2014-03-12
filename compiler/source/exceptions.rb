# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information
#

class CompileTimeError < StandardError
  attr_reader :parser, :tag, :message, :code, :directive, :trigger
  TAG = 'CompileTimeError'

  def initialize(tag, parser, options = {})
    @parser = parser
    @tag = tag
    @directive = options[:directive]
    @trigger = options[:trigger]
  end

  def code
    Log.internal TAG, 'Compile Time Exception doesn\'t override code method'
  end

  def message
    Log.internal TAG, 'Compile Time Exception doesn\'t override message method'
  end

  def help
    Log.internal TAG, 'Compile Time Exception doesn\'t override help method'
  end

  def to_s
    result = "[:#{self.code}]"
    if @trigger
      result += "#{@trigger}: #{self.message}\n#{@parser.mark_location @trigger}"
      if @directive
        result += "\nFor directive #{@directive.position}\n#{@parser.mark_location @directive.position}"
      end
    elsif @directive
      result += "#{@directive.position}: #{self.message}\n#{@parser.mark_location @directive.position}"
    else
      result += "#{self.message}"
    end
    result += "\n\n#{self.help}"
    return result
  end
end

class CompileInternalError < CompileTimeError
  def initialize(tag, parser, message, options)
    super tag, parser, options
    @message = message
  end

  def code
    :internal
  end

  def message
    "internal compile time error: #{@message}"
  end

  def help
    'This exception is triggered by an internal error, which may not indicate a problem with the story.'
  end

end

class SyntaxMissingBlockError < CompileTimeError
  def initialize(tag, directive)
    super tag, directive.parser, directive: directive, trigger: directive.parser.position
  end

  def code
    :'missing-block'
  end

  def message
    'missing text block'
  end

  def help
    'A text block was expected after this directive.'
  end
end

class SyntaxInvalidIdentifierError < CompileTimeError
  def initialize(tag, directive)
    super tag, directive.parser, directive: directive, trigger: directive.parser.position
  end

  def code
    :'invalid-identifier'
  end

  def message
    'invalid identifier'
  end

  def help
    'This directive is expecting a single, valid identifier.  A valid identifier consists of a single word, and must be preceeded with a forward slash (\) if all caps to differentiate it from a new directive.'
  end
end

class SyntaxUnexpectedStateDirective < CompileTimeError
  def initialize(tag, parser, directive, expected = [])
    super tag, parser, directive: directive, trigger: parser.position
    @expected = expected
  end

  def code
    :'unexpected-state-directive'
  end

  def message
    res = 'unexpected state directive'
    unless @expected.empty?
      res += ', expected '
      @expected.each_index do |i|
        res += ', ' if i != 0
        res += 'or ' if i + 1 == @expected.length && i > 0
        res += @expected[i].upcase.to_s
      end
    end
    return res
  end

  def help
    'This directive was unexpected in this context.  For example, a WHILE directive expects to be concluded with an END directive.'
  end
end

class ParsingError < StandardError
  attr_reader :directive, :message, :token, :position

  def initialize(directive, message, token = nil, position = nil)
    @directive = directive
    @message = message
    @token = token
    @position = position

    unless @directive.nil?
      @token = @directive.token if @token.nil?
      @position = @directive.position if @position.nil?
    end
  end

  def to_s
    "#{@position} on '#{@token}': #{message}"
  end
end

