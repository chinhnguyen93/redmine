require 'test_helper'

class AddDevelopersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get add_developers_new_url
    assert_response :success
  end

  test "should get create" do
    get add_developers_create_url
    assert_response :success
  end

end
