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

  test "post create" do
    File.open('build.log').each do |data|
      data_base64 = Base64.encode64(data)

      post packages_path,
        params: { data_base64: data_base64 },
        headers: { HTTP_X_SIGNTURE: OpenSSL::HMAC.hexdigest("SHA256", ENV['KISS2U_AUTH_KEY'] || '', "data_base64=#{data_base64}") }

      puts JSON.parse(response.body)

    end
    #assert_response :success
    #assert_response :redirect
    #follow_redirect!
  end
end
