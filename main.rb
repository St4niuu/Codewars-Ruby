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

#16 The Greatest Warrior

class Warrior

  attr_reader :level, :rank, :experience, :achievements

  @@RANKS = ["Pushover", "Novice", "Fighter", "Warrior", "Veteran", "Sage", "Elite", "Conqueror", "Champion", "Master", "Greatest"]
  def initialize()
    @level = 1
    @rank = @@RANKS.first
    @experience = 100
    @achievements = []
  end
  def battle(level)
    case true
      when (level < 1 or level > 100) then "Invalid level"
      when @level === level then update_experience(10, level: level)
      when @level - level === 1 then update_experience(5, level: level)
      when @level - level >= 2 then update_experience(0, level: level)
      when ((@@RANKS.index(@rank) - (level/10).floor) <= -1 and (@level - level <= -5)) then "You've been defeated"
      else update_experience(20 * ((level - @level).abs) * ((level - @level).abs), level: level)
    end
  end
  def training(data)
    if @level - data[2] >= 0
      @achievements << data[0]
      update_experience(data[1], achievement: data[0])
    else "Not strong enough"
    end
  end
  private
  def update_level()
    @level = (@experience/100).floor
  end
  def update_rank()
    @rank = @@RANKS[(@level/10).floor]
  end
  def update_experience(amount, level: nil, achievement: nil)
    levels = [@level, level]
    @experience = @experience + amount > 10000 ? 10000 : @experience + amount
    update_level()
    update_rank()
    if !level.nil?
      case true
        when levels[0] - levels[1] >= 2 then "Easy fight"
        when ((levels[0] - levels[1] === 0) or (levels[0] - levels[1] === 1)) then "A good fight"
        else "An intense fight"
      end
    else
      achievement
    end
  end
end

#17 Scheduling

def roundRobin(jobs, slice, index)
  result = 0
  while jobs[index] != 0
    jobs.map!.with_index do |element, iterationIndex|
      if element - slice <= 0 then
        result += element
        if index == iterationIndex then return result
        end
        0
      else
        result += slice
        element - slice
      end
    end
  end
  result
end

#18 Validate Sudoku with size 'NxN'

class Sudoku
  def initialize(data)
    @board = data
  end
  def valid?
    @board.map! do |element|
      element.map!(&:to_s).map!(&:to_i)
    end
    n = @board.length
    for x in 0...n
      row = Set.new
      column = Set.new
      @board[x].each do |element|
        if element > n or element < 1 then return false
        else row.add(element)
        end
      end
      for y in 0...n
        if @board[y][x] > n or @board[y][x] < 1 then return false
        else column.add(@board[y][x])
        end
      end
      if row.length != n or column.length != n then return false end
    end
    squares = []
    dimension = Math.sqrt(n).to_i
    for blockX in 0...dimension
      for blockY in 0...dimension
        tmp = []
        for y in blockY * dimension...blockY * dimension + dimension
          for x in blockX * dimension...blockX * dimension + dimension
            tmp << @board[x][y]
          end
        end
        squares << tmp
      end
    end
    squares.each do |element|
      if Set.new(element).to_a.length != n then return false end
    end
    true
  end
end

#19 Square and Cube of a Number Become Prime When Reversed

def isPrime(n)
  if n <= 1 then return false
  elsif n == 2 then return true
  else
    if n % 2 == 1
      (3..(Math.sqrt(n).floor)).step(2) do |x|
        if n % x == 0 then return false end
      end
    else return false
    end
  end
  true
end

@set = [89]

def sq_cub_rev_prime(n)
  if @set.length < n
    counter = @set.last + 1
    while true
      values = [counter ** 2, counter ** 3]
      values.map! {|element| element.to_s.reverse.to_i}
      if isPrime(values[0])
        if isPrime(values[1])
          @set.push(counter)
          return sq_cub_rev_prime(n)
        end
      end
      counter += 1
    end
  else return @set[n - 1]
  end
end

# To be optimized
# Doesn't work as intended

#20 Strings Mix

def mix(s1, s2)
  strings = [s1, s2]
  letters = []
  strings.each do |element|
    tmp = {}
    for letter in element.chars
      if letter == letter.downcase
        begin
          tmp[letter] += 1
        rescue
          tmp[letter] = 1
        end
      end
    end
    letters << tmp
  end
  puts letters[1].index(letters[1].values.max)
end

# To get done

#21 Human readable duration format

def format_duration(seconds)

  formats = ['years', 'days', 'hours', 'minutes', 'seconds']

  values = []

  dividers = [365, 24, 60, 60]

  if seconds > 0
    dividers.each_with_index do |_, index|
      divider = 1
      dividers[index..-1].each { |element| divider *= element }
      tmp = (seconds/divider).floor
      values.push(tmp)
      seconds -= tmp * divider
      if index == dividers.length - 1
        values.push(seconds)
      end
    end
  else return "now"
  end

  values = values.map.with_index do |element, index|
    {value: element, format: formats[index]}
  end.select do |element|
    element[:value] != 0
  end.map do |element|
    format = element[:value] > 1 ? element[:format] : element[:format][0..-2]
    "#{element[:value]} #{format}"
  end

  case values.length
  when 1 then values[0]
  else values[0..-2].join(", ") + " and #{values[-1]}"
  end

end
