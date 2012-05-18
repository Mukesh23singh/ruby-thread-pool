# Ruby Thread Pool

## All In Parallel
    require "thread_pool"
    require "open-uri"
    urls = ["http://google.com", "http://juergenbickert.de", "http://github.com"]
    urls.peach {|url| open(url).read }

All urls are retrieved in parallel. There is no limit on the amount of threads run in parallel.

## Limited Thread Pool Size
    require "thread_pool"
    20.times.to_a.peach(10) { sleep(0.1) }

It limits the thread pool size to 10 threads. So at any point in time there are at max running 10 threads, and it finishes in 0.2 seconds.

## Why is it better than peach

Because peach fails the third spec, unlike this fine piece of framework

    a = [0.01,0.01,0.2,0.2, 0.01, 0.01,0.01,0.01,0.01,0.01]
    start = Time.now
    a.peach(5) do |time|
      sleep time
    end
    stop = Time.now
    elapsed = stop - start
    elapsed.must_be :>=, 0.2
    elapsed.must_be :<=, 0.3