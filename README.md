# Using Server-Sent Events (SSE) in Ruby on Rails example

## Goals

* Consider ways to process SSE connections in Ruby On Rails application
* Show how using Rack Hijacking API allows to avoid blocking web server threads

For more information read [this article](http://blog.chumakoff.com/en/posts/rails_sse_rack_hijacking_api)

## Approaches

* ActionController::Live
* Rack Hijacking API (Full hijacking)
* Rack Hijacking API (Partial hijacking)

## Setting Puma threads count

Change default value in 'config/puma.rb' file

```
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
```

Or set RAILS_MAX_THREADS env variable when starting Rails server 

```
RAILS_MAX_THREADS=5 rails s

```