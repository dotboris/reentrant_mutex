ReentrantMutex
==============

A simple gem that implements a [reentrant mutex](https://en.wikipedia.org/wiki/Reentrant_mutex).

Installation
------------

1. Install it `gem install reentrant_mutex`
2. Require it `require 'reentrant_mutex'`
3. Use it

Usage
-----

This works exactly like a normal mutex except that you can lock a mutex you already have locked.

```ruby
require 'reentrant_mutex'

mutex = ReentrantMutex.new
mutex.synchronize do
  # . . .
end
```
