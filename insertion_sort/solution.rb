require 'pry'

def insertion_sort(array, idx = 1, sorted = [])
    return array if array.length == 1
    return sorted if idx + 1 > array.length

    sorted.push(array.first) if sorted.empty?

    if sorted.last <= array[idx]
        sorted.push(array[idx])

        idx += 1
        insertion_sort(array, idx, sorted)
    elsif sorted.last > array[idx]
        smaller, bigger = sorted.partition {|n| n <= array[idx] }
        smaller.push(array[idx])
        sorted = smaller + bigger

        idx += 1
        insertion_sort(array, idx, sorted)
    end
end

array = [4, 2, 24, 3, 6, -8, 9, 7, 0, 5, 1, 91, 4]

puts insertion_sort(array)