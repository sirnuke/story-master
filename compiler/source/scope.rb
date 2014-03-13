# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information
#

class Scope
  attr_reader :parent
  TAG = 'Scope'

  def initialize(parser, parent)
    @directives = []
    @parser = parser
    @parent = parent
  end

  def push(token)
    type, directive = Directive.create @parser, self, token
    if type == :state
      raise SyntaxUnexpectedStateDirective.new TAG, @parser, nil if @parent.nil?
      @parent.state directive
      @parent.validate token if @parent.complete?
      directive = @parent
    elsif type == :new
      unless @directives.empty? 
        if @directives.last.complete?
          @directives.last.validate token
        else
          Log.internal TAG, 'Should be appending new directive to the child\'s scope'
        end
      end
      @directives << directive
    else
      Log.internal TAG, "Unknown directive type of :#{type}"
    end

    if !directive.complete?
      active = directive.child
    elsif @parent.nil? || !@parent.complete?
      active = self
    else
      active = @parent.parent
    end

    return directive, active
  end

  def write_lua(output, tab)
    @directives.each do |directive|
      directive.write_lua output, tab
    end
  end

  def to_s
    result = ''
    @directives.each { |d| result += d.to_s }
    return result
  end
end
