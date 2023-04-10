# Thoughts on Linked Lists in General

Recently I began learning how to code in C#. One of the things that initially jumped out at me, and somewhat confused me, was that C# has both *arrays* and *lists*. Previous languages I have worked with, like Python or JavaScript, but primarily Ruby, typically have just *one* of these kinds of object, and they are *mutable* I thought it was puzzling that a language would have both, especially when (in C#) arrays are *immutable* (as in, they have a fixed size) whereas lists are *mutable* (as in, they do not have a fixed size). Why not just have lists then?

This mindset makes it difficult to understand the appeal of a linked list, but it is also indicative of a failure to think about what is going on *beneath* our code, as it were. I don't often think about memory allocation, for example, the process whereby the program I am writing allocates memory for the data I am storing in variables. That has not been something that I've needed to worry about so far in my career.

But I recently began reading Jeremy Kubica's book *Data Structures the Fun Way*, and he does a great job of explaining linked lists. It suddenly became clear to me why C# had both arrays and lists, and that what languages like Ruby must be doing under the hood in order to have mutable arrays available to me when I write a program.

The basic idea is this. Typically, when you initialize an array, a *determinate* amount of memory is allocated for storing the data in that array. This is why, for example, in C# you [typically](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/arrays/) need to specify in advance *how many elements* you expect your array to have:

```
  var exampleArray = new int[5]
```

This code generates a new array that can store 5 integers. In C#, you cannot add a sixth element to this array. If that's the kind of thing you want to do, you should use a list instead.

In a language like Ruby, you can generate an array very easily:

```
  my_ruby_array = Array.new(5)
```

This code generates a new array with 5 elements as well, although in this case they will all be `nil` until you input some values. Unlike with C#, however, you can add a sixth element like so:

```
  my_ruby_array.push(3)
```

This code simply adds the number `3` to the end of the array, which is something you cannot do in C#.

What is happening underneath the hood, however, is more complicated. Like C#, Ruby allocates a determinate amount of memory for storing `my_ruby_array` on initialization. When I *add* an element that goes beyond the initially established length, and therefore exceeds the memory allotted, Ruby must *create a new array with more allotted memory* in order to store that new element. I do not know the details of how Ruby does this - I would have to look at the actual code in C to find this out, and that is not something I am prepared to do at the moment. Perhaps Ruby uses Kubica's example of *array doubling*, perhaps not. The point at present is that underneath the hood, Ruby and C# both allot determinate amounts of memory upon the creation of an array. Ruby *seems* more flexible and straightforward than C# does by doing away with the latter's distinction between arrays and lists, but this is only because of magic happening underneath the hood.

It is precisely for reasons like this that linked lists are interesting as a data structure. A linked list shares many similarities with an array, but the key difference that makes it more flexible is that it does *not* have to be located in just one place in memory. Instead, a linked list is comprised of *nodes* that can all live *anywhere* in a computer's memory. As long as the nodes are appropriately *linked*, then the linked list will function perfectly.

To see the difference between linked lists and arrays, consider again what happens if we want to add a sixth element to `my_ruby_array`, which was initialized with just five elements. A brand new array will have to be created in memory that has a greater capacity for storage so it can handle this sixth element. Depending on how the underlying language handles this, it can be more or less efficient. For example, if it uses array doubling, then we will be able to add four additional elements (the seventh, eighth, ninth, and tenth) before we have to worry about memory allocation again. The downside is that if we never add these elements, or if we do not have to add these elements until much later, then we have wasted space in memory for elements that do not exist. If we opt instead to make sure we do not waste memory now, we may find ourselves continually having to generate new arrays every time a new element needs to be added to `my_ruby_array`.

Using a linked list can solve this problem. The list will initially consist of five *nodes*. The main difference between a node and an element of an array, for our purposes, is this: a node is *structured* in a way that an array element need not be. Specifically, a node contains both a *value* (which corresponds to the array element) and a *pointer*, which indicates the next node in the list. So whereas we might have an *array* that looks like this:

```
my_ruby_array = [1,2,3,4,5]
```

where this array must be stored in a single location in memory, a linked list employed to store the same data will start with a node like this:

```
node_one = {
    value = 1,
    pointer = node_two
}
```

The next node:

```
node_two = {
    value = 2,
    pointer = node_three
}
```

You can see where this is going. The final node will look like:

```
node_five = {
    value = 5,
    pointer = nil
}
```

The pointer here is `nil` to indicate that this is the last node. What makes this more flexible than an array is simply that these nodes can be stored individually anywhere in memory, rather than having to be stored as a single unit in a single location. This makes *adding* elements to the linked list much more straightforward. If I want to add a sixth element to the list, we simply need to update `node_five` like so:

```
node_five = {
    value = 5,
    pointer = node_six
}
```

And then we simply create a new node:

```
node_six = {
    value = 6,
    pointer = nil
}
```

This new node can live anywhere it likes in the computer's memory. As long as `node_five` is updated correctly so as to point to it, we will be able to find it.

This last point does highlight a downside to linked lists. Because arrays live in a single location in memory, once we know where they are, we can do things like *index into them* to grab particular elements in an efficient way. For example, I can do:

```
my_element = my_ruby_array[2]
```

This code will grab the third element of `my_ruby_array` (that is, `3`), so that I can use it.

With a linked list, by contrast, there is no way to index in. Because the data is strewn across the computer's memory, the only way that I can access the third element of the list is by *iterating through each node* until I find the node that I want. I *have* to start at the beginning and loop over the list until I identify the value that I am looking for.

This can make linked lists somewhat inefficient for searching purposes, but the tradeoff in terms of memory allocation is often worth it.

# Thoughts on My Solution to This Problem

After submitting the code in `solution.rb` on Leetcode, I discovered that my code had a runtime of 92ms. At time of writing, this beat just 55.88% of submissions on Leetcode for this problem. My code also took up 211 MB of memory. At time of writing, this actually beat 90.20% of submissions on Leetcode. So my solution does well in terms of memory allocation but is pretty average in terms of runtime.