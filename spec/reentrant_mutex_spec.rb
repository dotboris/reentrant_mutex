require 'spec_helper'

describe ReentrantMutex do
  let(:mutex) { ReentrantMutex.new }

  describe '#synchronize' do
    it 'should raise an error when no block is given' do
      expect{mutex.synchronize}.to raise_error
    end

    it 'should not raise an error when called twice' do
      expect{mutex.synchronize{mutex.synchronize{}}}.not_to raise_error
    end

    it 'should return whatever the block returns' do
      res = mutex.synchronize { 42 }
      expect(res).to eql(42)
    end

    it 'should yield the block' do
      expect{|b| mutex.synchronize &b}.to yield_with_no_args
    end

    it 'should leave the mutex unlocked' do
      mutex.synchronize {}

      expect(mutex.locked?).to be_false
    end
  end

  describe '#lock' do
    it 'should not deadlock when called twice' do
      mutex.lock
      expect{mutex.lock}.not_to raise_error
    end
  end

  describe '#unlock' do
    it 'should raise an error when called without a lock' do
      expect{mutex.unlock}.to raise_error
    end

    it 'should not raise an error when locked multiple times' do
      mutex.lock
      mutex.lock

      expect{mutex.unlock}.not_to raise_error
      expect{mutex.unlock}.not_to raise_error
    end
  end
end