require "thread"

class ThreadPool
  def initialize(pool_size)
    @pool = []
    @pool_size = pool_size
    @pool_mutex = Mutex.new
    @pool_cv = ConditionVariable.new
  end

  def run(*args)
    Thread.new do
      @pool_mutex.synchronize do
        while @pool.size >= @pool_size
          print "Pool is full: waiting to run #{args.join(",")}\n" if $DEBUG
          @pool_cv.wait(@pool_mutex)
        end
      end
      @pool << Thread.current
      begin
        yield(*args)
      rescue => e
        on_exception(self, e, *args)
      ensure
        @pool_mutex.synchronize do
          @pool.delete(Thread.current)
          @pool_cv.signal
        end
      end
    end
  end

  alias_method :new, :run

  def join
    sleep 0.001 # needed because join must be called after threads
                # had chance to lock
    @pool_mutex.synchronize { @pool_cv.wait(@pool_mutex) until @pool.empty? }
  end

  def on_exception(thread, exception, *original_args)
    # if you want to handle exception subclass and implement this method
  end
end

class Array
  def peach(size=nil, type=ThreadPool, &block)
    if size == nil
      threads = []
      each { |*args| threads << Thread.new(*args, &block) }
      threads.each {|t| t.join }
    else
      pool = type.new(size)
      each { |*args| pool.new(*args, &block) }
      pool.join
    end
  end
end
