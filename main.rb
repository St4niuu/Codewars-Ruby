#1 Draw me a chessboard

def chess_board(rows, columns)

  board = Array.new

  for row in 0..rows-1
    board.push(Array.new)
    for column in 0..columns-1
      case row % 2
      when 0
        board[row][column] = column % 2 === 0 ? 'O' : 'X'
      when 1
        board[row][column] = column % 2 === 0 ? 'X' : 'O'
      end
    end
  end

  return board

end

#2 Convert string to camel case

def to_camel_case(str)
  str.split(/[_-]/).map.with_index do |item, index|
    if index === 0
      item
    else
      item[0].upcase + item[1, item.length]
    end
  end.join("")
end

#3 Is this a triangle?

def is_triangle(*sides)
  sides = sides.sort
  sides[0] + sides[1] > sides[2] ? true : false
end

#4 Decipher this!

def decipher_this(string)
  string.split.map do |element|
    element.gsub!(/(\d+)/) { "#{$1.to_i.chr}" }
    if element.length != 1
      element[1], element[element.length - 1] = element[element.length - 1], element[1]
    end
    element
  end.join(" ")
end

#5 Find the unique number

require 'set'

def find_uniq(arr)
  Set.new(arr).to_a.each do |element|
    return element if arr.count(element) === 1
  end
end

#6 Valid Parentheses

def valid_parentheses(string)

  if string == ""
    return true
  end

  array = string.scan(/[()]/)

  tmp = Array.new

  case array[0]
  when "("
    return if (array.each do |element|
      if element === "("
        tmp << element
      elsif element === ")"
        return false if tmp.pop === nil
      end
    end) == false
    if tmp.length != 0 then false
    else true
    end
  else false
  end
end

#7 String increment

def increment_string(input)
  puts input
   if !input.scan(/\d/).empty?
    if input[input.length - 1].match(/\d/)
      input.gsub(/(0*)(\d+)/) { "#{($2.to_i + 1).to_s.length != $2.length ? $1[0...$1.length - 1] : $1}#{$2.to_i + 1}" }
    else
      input << "1"
    end
   else
    input << "1"
   end
end

#8 Memoized Fibonacci

@cache = {}

def fibonacci(n)
  if @cache[n]
    return @cache[n]
  end

  if n <= 1
    result = n
  else
    result = fibonacci(n - 1) + fibonacci(n - 2)
  end

  @cache[n] = result

  return result
end

#9 Sum of Pairs

def sum_pairs(ints, s)
  checked = {}
  ints.each do |element|
    return [s-element, element] if checked[s-element]
    checked[element] = true
  end
  return nil
end

#10 So many permutations!

require "set"

def generate(element, index, data, result, tmp, string)

  if tmp.length === string.length
    result.add(tmp.join(""))
  end
  data = data.reject.with_index { |elementR, indexR| elementR === element and indexR === index }
  data.each.with_index do |element, index|
    generate(element, index, data, result, Array.new(tmp).concat([element]), string)
  end
end

def permutations(string)
  result = Set.new

  data = string.split("")

  if data.length === 1
    result.add(data[0])
  else
    data.each.with_index do |element, index|
      generate(element, index, data, result, [].concat([element]), string)
    end
  end

  return result.to_a
end

#11 RGB To Hex Convertion

def rgb(*args)
  args.map! {|element| element > 255 ? 255 : element < 0 ? 0 : element }
  digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, "A", "B", "C", "D", "E", "F"]
  valuesToBeConverted = []
  result = ""
  args.each do |element|
    modulos = []
    if element >= 0 and element <= 15
      modulos.push(element, 0)
      valuesToBeConverted.push(modulos)
      next
    end
    until element < 16 do
      modulos.push(element % 16)
      element = (element / 16).floor
    end
    modulos.push(element)
    valuesToBeConverted.push(modulos)
  end
  valuesToBeConverted.map! { |element| element.reverse }
  valuesToBeConverted.each do |element|
    result << "#{digits[element[0]]}#{digits[element[1]]}"
  end
  return result
end

#12 Most frequently used words in a text

def top_3_words(text)
  return [] if text.scan(/[\w]/).empty?
  words = text.scan(/[\w\d']+/).map { |element| element.downcase }
  occourences = {}

  words.each do |element|
    occourences[element] = words.count(element) if !occourences[element]
  end
  top = occourences.sort_by {|key, value| value }.reverse[0..2]
  return top.map {|key, value| key}
end

#13 Snail

def snail(array)

  return [[]] if array.empty?

  x, y = array[0].length, array.length
  checked = {}

  for iteration in 0...array.map { |element| element.length }.sum
    if iteration ===  0
      checked["0-0"] = array[0][0]
    else
      index, _ = checked.entries.last
      index = index.split("-")
      if index[1].to_i + 1 < y and !!(array[index[0].to_i][index[1].to_i + 1]) and !(checked["#{index[0]}-#{index[1].to_i + 1}"])
        if index[0].to_i === 0
          checked["#{index[0]}-#{index[1].to_i + 1}"] = array[index[0].to_i][index[1].to_i + 1]
        elsif !(checked["#{index[0].to_i - 1}-#{index[1]}"])
          checked["#{index[0].to_i - 1}-#{index[1]}"] = array[index[0].to_i - 1][index[1].to_i]
        else
          checked["#{index[0]}-#{index[1].to_i + 1}"] = array[index[0].to_i][index[1].to_i + 1]
        end

      elsif index[0].to_i + 1 < x and !!(array[index[0].to_i + 1][index[1].to_i]) and !(checked["#{index[0].to_i + 1}-#{index[1]}"])
        checked["#{index[0].to_i + 1}-#{index[1]}"] = array[index[0].to_i + 1][index[1].to_i]
      elsif index[1].to_i - 1 >= 0 and !!(array[index[0].to_i][index[1].to_i - 1]) and !(checked["#{index[0]}-#{index[1].to_i - 1}"])
        checked["#{index[0]}-#{index[1].to_i - 1}"] = array[index[0].to_i][index[1].to_i - 1]
      elsif index[0].to_i - 1 >= 0 and !!(array[index[0].to_i - 1][index[1].to_i]) and !(checked["#{index[0].to_i - 1}-#{index[1]}"])
        checked["#{index[0].to_i - 1}-#{index[1]}"] = array[index[0].to_i - 1][index[1].to_i]
      end
    end
  end

  return checked.values.map { |element| element.to_i}

end

#14 How many numbers III?

def find_one(sum, count, start, current, result)
  if current.length === count
    if current.sum === sum
      result << current.join.to_i
    end
    return
  end
  start.upto(9) do |element|
    if current.empty? or element >= current[-1]
      find_one(sum, count, element, current + [element], result)
    end
  end
end

def find_all(sum, count)

  result = []

  find_one(sum, count, 1, [], result)

  return result.empty? ? [] : [result.length, result.first, result.last]

end

#15 The observed PIN

def get_one(data, current, result)
  if data.first.nil?
    result << current.join
    return
  end

  digits = {
    1 => [1, 2, 4],
    2 => [1, 2, 3, 5],
    3 => [2, 3, 6],
    4 => [1, 4, 5, 7],
    5 => [2, 4, 5, 6, 8],
    6 => [3, 5, 6, 9],
    7 => [4, 7, 8],
    8 => [0, 5, 7, 8, 9],
    9 => [6, 8, 9],
    0 => [0, 8]
  }

  digits[data.first].each do |element|
    get_one(data[1..-1], current + [element], result)
  end

end

def get_pins(observed)

  result = []

  get_one(observed.split("").map(&:to_i), [], result)

  return result
end
