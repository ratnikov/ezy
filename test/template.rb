require 'erb'

class Template
  def initialize(path, vars = {})
    vars.each { |(key, value)| instance_variable_set("@#{key}", value) }

    @_erb = ERB.new File.new(path).read
  end

  def to_s
    @_erb.result(binding)
  end
end
