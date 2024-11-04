def kids_with_candies(candies, extra_candies)
    candies.map do |kid|
        kid + extra_candies >= candies.max
    end
end

candies = [2,3,5,1,3]
extra_candies = 3

puts kids_with_candies(candies, extra_candies)

puts "-----"

candies = [4,2,1,1,2]
extra_candies = 1

puts kids_with_candies(candies, extra_candies)

puts "-----"

candies = [12,1,12]
extra_candies = 10

puts kids_with_candies(candies, extra_candies)