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
        # smaller, bigger = sorted.partition {|n| n <= array[idx] }
        # smaller.push(array[idx])
        # sorted = smaller + bigger

        smaller = sorted.reverse.find {|s| s <= array[idx] }
        if smaller
            smaller_idx = sorted.index(smaller)

            if smaller_idx == 0
                shifted = sorted.shift
                sorted.unshift(array[idx])
                sorted.unshift(shifted)
            else
                smaller_arr = sorted.slice(0, smaller_idx + 1)
                bigger_arr = sorted.slice(smaller_idx + 1, sorted.length)

                smaller_arr.push(array[idx])
                sorted = smaller_arr + bigger_arr
            end
        else
            sorted.unshift(array[idx])
        end

        idx += 1
        insertion_sort(array, idx, sorted)
    end
end

array = [4, 2, 24, 3, 6, -8, 9, 7, 0, 5, 1, 91, 4]

puts insertion_sort(array)