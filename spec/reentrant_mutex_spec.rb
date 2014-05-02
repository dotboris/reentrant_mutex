require 'spec_helper'

describe ReentrantMutex do
  let(:mutex) { ReentrantMutex.new }

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