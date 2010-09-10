require 'test_helper'

class ApplicationConfigTest < ActiveSupport::TestCase
  should("load settings correctly") do
    ApplicationConfig.load(File.join(Rails.root, 'test', 'fixtures', 'config'))

    assert_equal({ 'bar' => 'zeta' }, ApplicationConfig.foo)
  end
end
