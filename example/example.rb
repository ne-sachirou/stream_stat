# frozen_string_literal: true

# Example code reader
#
# example        := head empty_line description empty_line code
# head           := non_empty_line*
# description    := comment_line+
# code           := /.+/m
# empty_line     := /^\s*$/
# non_empty_line := /^\s*\S+.*$/
# comment_line   := /^#.*$/
class Example
  attr_reader :description, :code

  class << self
    def all
      Dir["#{__dir__}/*.rb"]
        .select { |file| File.basename(file, '.rb') =~ /\d+/ }
        .collect { |file| new file }
    end
  end

  def initialize(file)
    @file = file
    content = drop_head File.read(file, encoding: Encoding::UTF_8).each_line
    description_lines = content.take_while { |line| line[0] == '#' }
    @description = description_lines.join('').gsub(/^#\s*/, '').strip
    @code = content.drop(description_lines.size).join('').strip
  end

  def eval
    load @file
  end

  private

  def drop_head(content)
    content.drop_while { |line| line =~ /^\s*\S+.*$/ }.drop(1)
  end
end
