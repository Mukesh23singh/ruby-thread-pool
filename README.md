# Ruby Thread Pool

## All In Parallel
    require "open-uri"
    urls = ["http://google.com", "http://juergenbickert.de", "http://github.com"]
    urls.peach {|url| open(url).read }

it retrieves all data from sites in parallel

## Limited Thread Pool Size

    20.times.to_a.peach(10) { sleep(0.1) }

finishes in 0.2 seconds
