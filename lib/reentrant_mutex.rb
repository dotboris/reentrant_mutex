class ReentrantMutex < Mutex
  def initialize
    @count_mutex = Mutex.new
    @counts = Hash.new(0)

    super
  end

  def synchronize
    raise ThreadError, 'Must be called with a block' unless block_given?

    lock
    ret = yield
    unlock

    ret
  end

  def lock
    c = increase_count Thread.current
    super if c <= 1
  end

  def unlock
    c = decrease_count Thread.current
    if c <= 0
      super
      delete_count Thread.current
    end
  end

  private

  def increase_count(thread)
    @count_mutex.synchronize { @counts[thread] += 1 }
  end

  def decrease_count(thread)
    @count_mutex.synchronize { @counts[thread] -= 1 }
  end

  def delete_count(thread)
    @count_mutex.synchronize { @counts.delete(thread) }
  end
end
