require "detect_deprecation/version"

module ActiveSupport
  class Deprecation
    module Reporting
      def warn(message = nil, callstack = nil)
        return if silenced

        callstack ||= caller_locations(2)
        deprecation_message(callstack, message).tap do |m|
          behavior.each { |b| b.call(m, callstack, deprecation_horizon, gem_name) }
        end

        raise
      end
    end
  end
end
