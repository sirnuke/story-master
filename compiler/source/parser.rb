# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information
#

class Parser
  attr_reader :position, :name
  attr_accessor :filedata

  TAG = 'Parser'

  def initialize(name, filename = :$stdin)
    @name = name
    @position = Position.new filename
    @filedata = nil
    @directive = nil
    @scope = Scope.new(self, nil)
  end

  def self.file(name, filename)
    parser = Parser.new(name, filename)
    File.open filename, 'r' do |file|
      parser.filedata = file.read
    end
    return parser
  end

  def self.stdin(name)
    parser = Parser.new(name)
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

  def write_lua(out)
    out.puts "-- Autogenerated file from #{@position.filename} :: #{@name}"
    out.puts
    out.puts "-- Scene function for #{@name}"
    out.puts "function execute_#{@name}(ptr)"
    @scope.write_lua out, 1
    out.puts "end"
    out.puts
    out.puts "-- Setup function for #{@name}"
    out.puts
    out.puts "function setup_#{@name}(ptr)"
    out.puts "#{Constants::BASE_INDENT * 1}return {"
    out.puts "#{Constants::BASE_INDENT * 2}compiler_version_major = #{Constants::VERSION_MAJOR}, "
    out.puts "#{Constants::BASE_INDENT * 2}compiler_version_minor = #{Constants::VERSION_MINOR}, "
    out.puts "#{Constants::BASE_INDENT * 2}compiler_version_patch = #{Constants::VERSION_PATCH}, "
    out.puts "#{Constants::BASE_INDENT * 2}source_filename = \"#{@position.filename}\" "
    out.puts "#{Constants::BASE_INDENT * 1}}"
    out.puts "end"
    out.puts
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

