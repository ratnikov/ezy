require 'yaml'

module ApplicationConfig
  extend self

  def load(file_without_extension)
    file = "%s.yml" % file_without_extension

    if File.exists?(file) && yaml = YAML.load_file(file)
      settings.merge! yaml
    else
      warn "Failed to load configuration settings from #{file.inspect}"
    end
  end

  private

  def method_missing(method)
    return settings[method.to_s] if settings.has_key?(method.to_s)

    super
  end

  def settings
    @settings ||= { }

    @settings
  end
end
