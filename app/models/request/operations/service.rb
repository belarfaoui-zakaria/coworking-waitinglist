# frozen_string_literal: true

module Request::Operations::Service
  def initialize
    @success = false
    @ctx = ActiveSupport::HashWithIndifferentAccess.new
  end

  def [](key)
    # raise args.inspect
    @ctx[key]
  end

  module Klass
    def call(*args)
      service = new
      service.call(*args)
      service
    end
  end

  def success?
    @success
  end

  def self.included(base)
    class << base
      include Klass
    end
  end
end
