require 'test_helper'

class RoutesControllerTest < ActionController::TestCase
  context "#new" do
    setup { get :new }

    should render_template('new')
  end
end
