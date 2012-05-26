require_relative 'test_helper'
require 'hyperclient'

describe Hyperclient do
  let(:api) do
    Class.new do
      include Hyperclient
    end
  end

  describe 'entry point' do
    it 'sets the entry point for Hyperclient::Resource' do
      api.entry_point 'http://my.api.org'

      Hyperclient::Resource.new('/').url.must_include 'http://my.api.org'
    end
  end

  describe 'method missing' do
    class Hyperclient::Resource
      def foo
        'foo'
      end
    end

    it 'delegates undefined methods to the API when they exist' do
      api.new.foo.must_equal 'foo'
    end

    it 'raises an error when the method does not exist in the API' do
      lambda { api.new.this_method_does_not_exist }.must_raise(NoMethodError)
    end
  end
end