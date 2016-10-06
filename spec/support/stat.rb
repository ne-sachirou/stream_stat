# frozen_string_literal: true

def sum(arr)
  arr.inject(:+).to_f
end

def avg(arr)
  sum(arr) / arr.size
end

def variance(arr)
  avg = avg arr
  sum(arr.collect { |item| (item - avg)**2 }) / arr.size
end

def sd(arr)
  Math.sqrt variance arr
end
