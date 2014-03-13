# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information
#

class Directive
  attr_reader :type, :token, :position, :parent, :parser
  TAG = 'Directive'

  def initialize(parser, parent, token)
    @parent = parent
    @child = nil
    @block = Block.new
    @token = token.dup
    @parser = parser
    @position = parser.position.dup
    @type = :undefined
  end

  def self.create(parser, parent, token)
    case token
    when 'END'
      return :state, :END
    when 'ASK'
      return :state, :ASK
    when 'ELSEIF'
      return :state, :ELSEIF
    when 'ELSE'
      return :state, :ELSE
    when 'IDENTIFIER'
      return :new, Identifier.new(parser, parent, token)
    when 'PROJECT'
      return :new, Project.new(parser, parent, token)
    when 'SCENE'
      return :new, Scene.new(parser, parent, token)
    when 'AUTHOR'
      return :new, Author.new(parser, parent, token)
    when 'DATE'
      return :new, StoryDate.new(parser, parent, token)
    when 'IF'
      return :new, If.new(parser, parent, token)
    when 'UNTIL'
      return :new, Loop.new(parser, parent, token)
    when 'WHILE'
      return :new, Loop.new(parser, parent, token)
    when 'LOOP'
      return :new, Loop.new(parser, parent, token)
    when 'FOR'
      return :new, Loop.new(parser, parent, token)
    when 'BREAK'
      return :new, Break.new(parser, parent, token)
    when 'CHOICE'
      return :new, Choice.new(parser, parent, token)
    when 'PROMPT'
      return :new, Prompt.new(parser, parent, token)
    else
      return :new, Dialog.new(parser, parent, token)
    end
  end

  def child
    Log.internal TAG, "Directive #{self.type} doesn't have a child scope" unless @child
    @child
  end

  # This is almost certainly an internal error. A directive that has a
  # child scope almost certainly should override this function.
  def state(token)
    raise SyntaxUnexpectedStateDirective.new TAG, @parser, self 
  end

  def validate(token)
    Log.internal TAG, "Directive #{self.type} doesn't implement the validate method"
  end

  def complete?
    true
  end

  def append(token)
    @block.append token
  end

  def write_lua(out, tab)
    Log.internal TAG, "Directive #{self.type} doesn't implement the write_lua method"
  end

  def to_s
    Log.internal TAG, "Directive #{self.type} doesn't implement to_s method"
  end
end


Dir.chdir './directives/' do
  require './project'
  require './dialog'
  require './identifier'
  require './scene'
  require './if'
  require './loop'
  require './choice'
  require './prompt'
  require './author'
  require './date'
  require './break'
end

