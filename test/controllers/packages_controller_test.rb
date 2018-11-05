require 'test_helper'

class PackagesControllerTest < ActionDispatch::IntegrationTest
  test "get index" do
    get packages_path
    assert_response :success
  end

  test "get show" do
    get '/api/packages/blender-2.8-git'
    #puts JSON.parse(response.body)
    assert_response :success
  end
end
