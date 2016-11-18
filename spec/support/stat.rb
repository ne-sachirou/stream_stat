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

def medium(arr)
  size = arr.size
  sorted = arr.sort
  if size.even?
    sorted[size / 2 - 1]
  else
    (sorted[size / 2 - 1] + sorted[size / 2]) / 2.0
  end
end

def mode(arr)
  arr.each_with_object({}) { |i, map| map[i] = (map[i] || 0) + 1 }
     .max_by { |_i, count| count }[0]
end
