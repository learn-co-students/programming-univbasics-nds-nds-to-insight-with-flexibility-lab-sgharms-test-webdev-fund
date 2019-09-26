# Getting Insight from Nested Data Structures (Flexibly)

## Learning Goals

* See-saw between bottom-up and top-down method writing

## Introduction

So far, we've seen the power of wrapping "primitive" Ruby calls in methods.
We've also seen the power of wrapping "First-Order" methods inside other
methods.

This practice of constructing programs is **superior** since it helps
readability and maintainability compared to "writing one big old set of nested
loops."

Sometimes though it's not so clear how to get from a _given_ NDS to the NDS
that we might need. It's easy to to feel "stuck." It happens to programmers all
the time!

When this happens, we need to think _flexibly_ and work from what we're given
and get _one_ tiny step closer to the final goal &mdash; even if we can't see
the finish line. Or, maybe we need to hard-code or type an example of the goal
and work backwards from it.  We like to call this approach the "see-saw"
approach (or "teeter-totter"). The idea is that Ruby is your partner on the
see-saw: you get a step closer to the solution, it gets a step away from the
solution _toward you_, back-and-forth until you meet in the middle and share in
the glory of a job well done.

## See-saw Between Bottom-up and Top-down Method Writing

Lets consider our vending machine. Snacks, as we have seen, know how many
pieces they have. The _insight_ we'd like to have is:

> How many snacks have `1` piece, how many have `2` pieces, `3`, `999`, `1000`,
> etc.

So we'd like a `Hash` where the keys are `Integer`s representing "piece-count"
and the keys' values are the "number of snacks with that many pieces."

Recalling the effort we took to print out and understand the vending machine
NDS, we know that the NDS is not set up to give us that information easily
(that's why Step 1 is so important!)  We need to _transform_ the _given_ NDS
into something else, a _new_ NDS, that allows us to derive _insights_ from
_it_.

> **REAL-LIFE PROGRAMMING ESSENTIAL**: This very much mirrors some real-world
> use of 3<sup>rd</sup> party information.  A Wiki of Ice and Fire (a site with
> information about the popular "Song of Ice and Fire" book series) has tons of
> information that it returns as an NDS. To get information we want out if it,
> one has to to transform their _given_ data to a form that provides the
> answers one wants.

This transformation is **not** simple. It will require multiple steps. Instead
of locking ourselves into solving the problem by starting from the _given_ NDS
and working to the end, we're going to be flexible. We'll work from our _given_
NDS, and we'll work backward from an imagined, desired _answer_ NDS.

### See-...

```ruby
vm = [[[{:name=>"Vanilla Cookies", :pieces=>3}, {:name=>"Pistachio Cookies",
:pieces=>3}, {:name=>"Chocolate Cookies", :pieces=>3}, {:name=>"Chocolate Chip
Cookies", :pieces=>3}], [{:name=>"Tooth-Melters", :pieces=>12},
{:name=>"Tooth-Destroyers", :pieces=>12}, {:name=>"Enamel Eaters",
:pieces=>12}, {:name=>"Dentist's Nighmare", :pieces=>20}], [{:name=>"Gummy Sour
Apple", :pieces=>3}, {:name=>"Gummy Apple", :pieces=>5}, {:name=>"Gummy Moldy
Apple", :pieces=>1}]], [[{:name=>"Grape Drink", :pieces=>1}, {:name=>"Orange
Drink", :pieces=>1}, {:name=>"Pineapple Drink", :pieces=>1}], [{:name=>"Mints",
:pieces=>13}, {:name=>"Curiously Toxic Mints", :pieces=>1000}, {:name=>"US
Mints", :pieces=>99}]]]
```

Look at the _given_ NDS. Where are the `:pieces` data? How can we get to them?
Here you can use the knowledge you gained from "Step 1:  Understand the NDS"
and "Step 2: Use `[]` to verify your understanding from Step 1" to confirm your
understanding of the _given_ NDS.

### -Saw...

What do we want? Something like:

```ruby
# Not runnable!
{
  3 => 4,
 1000 => 1
}
```

We'll call this the "_answer_ NDS."

It seems like a long way from the _given_ NDS to the _answer_ NDS. Let's try to
imagine a middle point we can get to that would make getting the _answer_ NDS
easy.

Could we get to a world where we have only one big-old `Array` of the snack
`Hash`es?

_If we could_, we could cut out the whole "row" and "column" noise . Then, for
each snack, We could find out how many pieces are in the snack and use that
`:piece` `Integer` as a key. Then for each snack with that same `:piece`
`Integer`, we could increment a "times seen" number by one.

Let's aim to make that happen by transforming the _given_ NDS.

### See-...

```ruby
vm = [[[{:name=>"Vanilla Cookies", :pieces=>3}, {:name=>"Pistachio Cookies",
:pieces=>3}, {:name=>"Chocolate Cookies", :pieces=>3}, {:name=>"Chocolate Chip
Cookies", :pieces=>3}], [{:name=>"Tooth-Melters", :pieces=>12},
{:name=>"Tooth-Destroyers", :pieces=>12}, {:name=>"Enamel Eaters",
:pieces=>12}, {:name=>"Dentist's Nighmare", :pieces=>20}], [{:name=>"Gummy Sour
Apple", :pieces=>3}, {:name=>"Gummy Apple", :pieces=>5}, {:name=>"Gummy Moldy
Apple", :pieces=>1}]], [[{:name=>"Grape Drink", :pieces=>1}, {:name=>"Orange
Drink", :pieces=>1}, {:name=>"Pineapple Drink", :pieces=>1}], [{:name=>"Mints",
:pieces=>13}, {:name=>"Curiously Toxic Mints", :pieces=>1000}, {:name=>"US
Mints", :pieces=>99}]]]

def snack_collection(machine)
  collection = []
  row_index = 0
  while row_index < machine.length do
    column_index = 0
    while column_index < machine[row_index].length do
      inner_len = machine[row_index][column_index].length
      inner_index = 0
      while inner_index < inner_len do
        collection <<
          machine[row_index][column_index][inner_index]
        inner_index += 1
      end
      column_index += 1
    end
    row_index += 1
  end
  collection
end

p snack_collection(vm)
```

Outputs:

```ruby
[{:name=>"Vanilla Cookies", :pieces=>3}, {:name=>"Pistachio Cookies", :pieces=>3}, {:name=>"Chocolate Cookies", :pieces=>3}, {:name=>"Chocolate Chip\nCookies", :pieces=>3}, {:name=>"Tooth-Melters", :pieces=>12}, {:name=>"Tooth-Destroyers", :pieces=>12}, {:name=>"Enamel Eaters", :pieces=>12}, {:name=>"Dentist's Nighmare", :pieces=>20}, {:name=>"Gummy Sour\nApple", :pieces=>3}, {:name=>"Gummy Apple", :pieces=>5}, {:name=>"Gummy Moldy\nApple", :pieces=>1}, {:name=>"Grape Drink", :pieces=>1}, {:name=>"Orange\nDrink", :pieces=>1}, {:name=>"Pineapple Drink", :pieces=>1}, {:name=>"Mints", :pieces=>13}, {:name=>"Curiously Toxic Mints", :pieces=>1000}, {:name=>"US\nMints", :pieces=>99}]
```

Let's give this `Array` a name to make this lesson clearer, let's call this the
"Snacks Collection"

> **Reflect** Are there methods you think we should extract from this code? If
> so, try writing some methods and make sure you get the same output!

Not bad, right! Using some simple iteration we were able to transform the
_given_ NDS into something that is our midpoint. Now all we need to do is
finish the path from our midpoint to the goal NDS.

### -Saw...

We know we want a `Hash` like:

```ruby
# Not runnable!
{
  3 => 4, # 4 candies
  1000 => 1 ...
}
```

Let's transform that snacks `Array` into the "Summary `Hash`".

```ruby
vm = [[[{:name=>"Vanilla Cookies", :pieces=>3}, {:name=>"Pistachio Cookies",
:pieces=>3}, {:name=>"Chocolate Cookies", :pieces=>3}, {:name=>"Chocolate Chip
Cookies", :pieces=>3}], [{:name=>"Tooth-Melters", :pieces=>12},
{:name=>"Tooth-Destroyers", :pieces=>12}, {:name=>"Enamel Eaters",
:pieces=>12}, {:name=>"Dentist's Nighmare", :pieces=>20}], [{:name=>"Gummy Sour
Apple", :pieces=>3}, {:name=>"Gummy Apple", :pieces=>5}, {:name=>"Gummy Moldy
Apple", :pieces=>1}]], [[{:name=>"Grape Drink", :pieces=>1}, {:name=>"Orange
Drink", :pieces=>1}, {:name=>"Pineapple Drink", :pieces=>1}], [{:name=>"Mints",
:pieces=>13}, {:name=>"Curiously Toxic Mints", :pieces=>1000}, {:name=>"US
Mints", :pieces=>99}]]]

def snack_collection(machine)
  flat_snack_collection = []
  row_index = 0
  while row_index < machine.length do
    column_index = 0
    while column_index < machine[row_index].length do
      inner_len = machine[row_index][column_index].length
      inner_index = 0
      while inner_index < inner_len do
        flat_snack_collection <<
          machine[row_index][column_index][inner_index]
        inner_index += 1
      end
      column_index += 1
    end
    row_index += 1
  end
  flat_snack_collection
end


def summary_snack_count_by_pieces(snacks)
  result = {}
  i = 0

  while i < snacks.length do
    snack_name = snacks[i][:name]
    snack_pieces = snacks[i][:pieces]
    # If there's no key for this number, add the number as a key and assign it
    # a new Array for holding future snacks with that number of pieces.
    if !result[snack_pieces]
      result[snack_pieces] = 1
    else
      result[snack_pieces] += 1
    end
    i += 1
  end

  result
end

pieces_collection = snack_collection(vm)
p summary_snack_count_by_pieces(pieces_collection) #=>
  {3=>5, 12=>3, 20=>1, 5=>1, 1=>4, 13=>1, 1000=>1, 99=>1}
```

Look at that! We have that thing we wanted! We've used the see-saw technique to
do some really complex work to create a clear summary.

> **Reflect** Are there methods you think we should extract from this code? If
> so, try writing some methods and make sure you get the same output!

## Lab

In the lab, you're going to transform the given data into a `Hash` with
information about various move studios. Use the see-saw technique to work from
the given NDS to a "midpoint" NDS.

To help "train up" your see-saw technique skills, we've provided you code that
***you should not change***. This is very similar to the real world where you
can't throw out other methods (because you might break something!).

The "main method" that returns the summary of earnings per studio ***will not
be yours to edit***. That method, `studios_totals`, uses the methods listed
above. This will help train you up for the very-real-world case of modifying
pre-existing code.

You're only responsible for implementing the methods

* `movies_with_director_key(name, movies_collection)`; is used by
  `movies_with_directors_set`
* `movies_with_directors_set(source)`
* `gross_per_studio(collection)`

You're welcome to use methods that we've provided in your implementations.
They're "helpers." You might not need them.

Details about the arguments and the expected return tyhpes are provided in
comments in `lib/nds_extract.rb`.

## Conclusion

In this lab, you've learned one of the most important techniques for being a
developer: see-sawing or "working backward." While it's easy to say "Oh,
programmers they often work backward," we've seen lots of students get stuck
thinking that programming only works in _one_ direction. This lab is designed
to help you see how the see-saw technique applies to transforming NDS to
generate _insights_.

The NDS' you need to do work as a professional will sometimes feel "out of
reach." If you feel stuck, it's OK to type in (or, "hard-code") what you want
and code to get to there instead of the far-off final result.

The next lab will be a chance to put all the skills you've learned about NDS'
together. Remember your training! Remember to analyze the NDS, create methods
that help you do your work, and use the see-saw technique!
