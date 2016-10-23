# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :fuzzy_eq do |expected|
  fuzzy_eq = lambda do |l, r|
    case l
    when Numeric
      (l - r).abs < 1e-12
    when Enumerable
      l.count == r.count && l.zip(r).all? { |le, re| fuzzy_eq[le, re] }
    else
      l == r
    end
  end
  match { |actual| fuzzy_eq[expected, actual] }
  diffable
end
