def merge_alternately(word1, word2)
    new_word_arr = []
    word1_arr = word1.split("")
    word2_arr = word2.split("")

    while word1_arr.length > 0 && word2_arr.length > 0
        new_word_arr << word1_arr[0]
        word1_arr = word1_arr.slice(1..-1)
        new_word_arr << word2_arr[0]
        word2_arr = word2_arr.slice(1..-1)
    end

    full_arr = if word1_arr.length > 0
        new_word_arr + word1_arr
    else
        new_word_arr + word2_arr
    end

    full_arr.join()
end

puts merge_alternately("abc", "pqr")
puts merge_alternately("ab", "pqrs")
puts merge_alternately("abcd", "pq")