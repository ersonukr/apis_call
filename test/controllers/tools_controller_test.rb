require 'test_helper'

class ToolsControllerTest < ActionController::TestCase
  test "should get check_caimpaign" do
    get :check_caimpaign
    assert_response :success
  end

end
