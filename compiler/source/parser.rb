# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information
#

class Parser
  attr_reader :position 
  attr_accessor :filedata

  TAG = 'Parser'

  def initialize(filename = :$stdin)
    @position = Position.new filename
    @filedata = nil
    @directive = nil
    @scope = Scope.new(self, nil)
  end

  def self.file(filename)
    parser = Parser.new filename
    File.open filename, 'r' do |file|
      parser.filedata = file.read
    end
    return parser
  end

  def self.stdin
    parser = Parser.new
    parser.filedata = ''
    $stdin.each_line { |line| parser.filedata += line + "\n" }
    return parser
  end

  def parse
    begin
      @filedata.each_line do |line|
        Tokenizer.tokenize line, @position do |type, token|
          case type
          when :directive
            @directive, @scope = @scope.push token
          when :data
            raise ParsingError.new nil, 'data before the first directive', token, @position if @directive.nil?
            @directive.append token
          else
            Log.internal TAG, "Unknown token type :#{type}\n#{mark_location @position}"
          end
        end
      end
      @position.eof = true
      @directive.validate nil unless @directive.nil?
      scope = @scope
      while scope.parent
        scope.parent.validate nil
        scope = scope.parent.parent
      end
    rescue CompileTimeError => e
      Log.e e.tag, e.to_s
    rescue ParsingError => e
      Log.e TAG, "#{e.to_s}\n#{mark_location e.position}"
    end
  end

  def mark_location(position)
    result = ''
    number = 1
    context = 0
    character = position.character
    filedata.each_line do |line|
      if number >= position.line - context && number <= position.line + context
        if number == position.line
          result += ">>#{line}>>"
          char = 0
          character = line.length if position.eof
          while char < character
            result += ' '
            char += 1
          end
          result += "^\n"
        else
          result += line 
        end
      end
      number += 1
    end
    return result
  end

  def to_s
    @scope.to_s
  end
end

