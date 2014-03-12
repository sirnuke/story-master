# StoryMaster Compiler
# Bryan DeGrendel (c) 2014
#
# See LICENSE for licensing information
#

class Tokenizer
  def self.tokenize(line, position, &block)
    data = line.lstrip
    position.next line.length - data.length
    return if !data.empty? && data[0] == '#'
    data.scan(/\S+\s*/) do |raw|
      type, token = decode raw
      position.increment raw
      yield type, token unless type == :empty
    end
  end

  def self.decode(raw)
    token = raw.strip
    # Empty token after stripping? Ignore
    return :empty, '' if token.empty?
    # Starts with an escape character (\)? Data
    return :data, token[1..-1] if token[0] == '\\'
    # Remove before/after non-word characters
    parsed = token.gsub(/(^[^\w-]+|[^\w-]+$)/, '')
    # Length is less than two? Data (only non-words, or something like 'I')
    return :data, token if parsed.length < 2
    # Has no lower-case letters, and at least one upper case? Directive
    return :directive, parsed if parsed.index(/[a-z]/).nil? and not parsed.index(/[A-Z]/).nil?
    # Otherwise? Data
    return :data, token
  end
end

