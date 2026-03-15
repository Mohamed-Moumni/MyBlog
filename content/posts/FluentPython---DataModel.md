---
title: "FluentPython - DataModel"
date: 2026-03-15
draft: false
description: "The backbone of Python programming language that formalizes the interfaces for building blocks like sequences, iterators, and functions."
tags: ["Programming", "Languages", "systems", "Python"]
categories: ["Programming", "Languages", "systems", "Python"]
slug: "Fluent Python - DataModel"
---

Every Python object consists of specific methods called magic methods or dunder methods.
These methods allow your custom objects to interact with fundamental language constructs like collections, iteration, and operator overloading.

For example: `len`

The len function is the result of implementing the __len__ magic method.


```python
import collections

Card = collections.namedtuple('Card', ['rank', 'suit'])


class FrenchDeck:
    ranks = [str(n) for n in range(2, 11)] + list('JQKA')
    suits = 'spades diamonds clubs hearts'.split()

    def __init__(self):
        self._cards = [Card(rank, suit) for suit in self.suits
                                        for rank in self.ranks]

    def __len__(self):
        return len(self._cards)

    def __getitem__(self, position):
        return self._cards[position]


deck = FrenchDeck()

print(len(deck)) ## 52

print(deck[2]) ## Card(rank='4', suit='spades')
    
```


Those methods are meant to be called by the Python interpreter, not by the programmer. If you implement the __len__ method, you should call len(my_obj) directly — it will automatically invoke __len__ through the interpreter.

This implementation also helps you leverage the standard library. If you implement __getitem__ and __len__, your class will automatically become compatible with Python's standard library.

There are many ways to customize your object; one of those is represented in the table below:

The Data Model defines over 80 special method names, the most common ones mentioned are:


| Category | Special Methods |
|---|---|
| Collection/Sequence   | `__len__, __getitem__, __contains__` |
| Object Representation | `__repr__, __str__, __format__, __bytes__`|
| Arithmetic Operators  | `__add__, __mul__, __abs__, __matmul__`|
| Boolean Context       | `__bool__`|
| Lifecycle             | `__init__, __new__, __del__`|