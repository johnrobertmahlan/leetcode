require 'pry'

def search(nums, target, old_nums: nil)
  if old_nums.nil?
    old_nums = nums
  end

  return -1 if nums.empty?

  middle = nums.length / 2

  if target == nums[middle]
    return old_nums.index(nums[middle])
  elsif target > nums[middle]
    left, right = middle + 1, nums.length - (middle + 1)

    return search(nums.slice(left, right), target, old_nums: old_nums)
  else
    left, right = 0, middle

    return search(nums.slice(left, right), target, old_nums: old_nums)
  end
end

  nums = [-1,0,3,5,9,12]

  puts search(nums, 9)
  puts search(nums, 2)