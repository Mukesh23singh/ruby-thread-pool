require "minitest/autorun"
require_relative "../lib/thread_pool"

describe "ThreadPool" do
  it "should run at max so many threads" do
    require "peach"
    start = Time.now
    20.times.to_a.peach(10) { sleep(0.1) }
    stop = Time.now
    time = stop - start
    time.must_be :>=, 0.2
    time.must_be :<=, 0.3
  end

  it "should not stop on long running threads" do
    a = [0.01,0.01,0.2,0.2, 0.01, 0.01,0.01,0.01,0.01,0.01]
    start = Time.now
    a.peach(5) do |time|
      sleep time
    end
    stop = Time.now
    elapsed = stop - start
    elapsed.must_be :>=, 0.2
    elapsed.must_be :<=, 0.3
  end
end
