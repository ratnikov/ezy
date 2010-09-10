# Speed up escaping and patch rack UTF warning
require 'escape_utils/html/rack'
require 'escape_utils/html/erb'

# Fix the pesky UTF8 warning for cucumber
module Rack
  module Utils
    def escape(s)
      EscapeUtils.escape_url(s)
    end
  end
end
