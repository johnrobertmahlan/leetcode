def merge_alternately(word1, word2)
    return merge_same_lengths(word1, word2) if word1.length == word2.length
    return merge_different_lengths(word1, word2)
end

def merge_same_lengths(word1, word2)
    new_word_arr = []
    word1_arr = word1.split("")
    word2_arr = word2.split("")
    length = word1.length

    length.times do |time|
        new_word_arr << word1_arr[0]
        word1_arr = word1_arr.slice(1..-1)
        new_word_arr << word2_arr[0]
        word2_arr = word2_arr.slice(1..-1)
    end

    new_word_arr.join()
end

def merge_different_lengths(word1, word2)
    new_word_arr = []
    word1_arr = word1.split("")
    word2_arr = word2.split("")
    word_lengths = [word1.length, word2.length]

    word_lengths.min.times do |time|
        new_word_arr << word1_arr[0]
        word1_arr = word1_arr.slice(1..-1)
        new_word_arr << word2_arr[0]
        word2_arr = word2_arr.slice(1..-1)
    end

    remaining_word_arr = word1_arr.length == 0 ? word2_arr : word1_arr

    remaining_word_arr.length.times do |time|
        new_word_arr << remaining_word_arr[0]
        remaining_word_arr = remaining_word_arr.slice(1..-1)
    end

    new_word_arr.join()
end

puts merge_alternately("abc", "pqr")
puts merge_alternately("ab", "pqrs")
puts merge_alternately("abcd", "pq")