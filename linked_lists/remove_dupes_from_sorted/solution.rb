require 'pry'

# Leetcode provides this class for handling its linked lists
class ListNode
    attr_accessor :val, :next

    def initialize(val = 0, _next = nil)
        @val = val
        @next = _next
    end
end

def delete_duplicates(head)
  return head if head.nil?

  current = head

  while !current.next.nil?
    # Compare current.val to current.next.val
    if current.val == current.next.val
      # Input: [1,1,2]
      # Example: current.val == 1 && current.next.val == 1
      # So I need to delete one of these and update the pointers
      current.next = current.next.next
    else
      current = current.next
    end
  end

  head
end

# This feels like the wrong way to set up the linked list given what Leetcode says
# But makes the most sense given my understanding of what a linked list is
third = ListNode.new(val = 2, _next = nil)
second = ListNode.new(val = 1, _next = third)
head = ListNode.new(val = 1, _next = second)

# This more closely matches what Leetcode says the input is ("Input: [1,1,2]")
# But head.val on Leetcode is 1 and head.next.next.val is 2, so the above is right
new_head = ListNode.new(val = [1,1,2], _next = nil)

# What is weird to me, though, is that running this just shows a single node (where node.val == 1)
# Yet on LeetCode, my solution was accepted as "returning" [1,2] when given [1,1,2]
# So I'm a little confused about the return value, but there must be something under the hood I'm missing
puts delete_duplicates(head)