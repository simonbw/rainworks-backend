require 'test_helper'

class RainworksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rainwork = rainworks(:one)
  end

  test "should get index" do
    get rainworks_url, as: :json
    assert_response :success
  end

  test "should create rainwork" do
    assert_difference('Rainwork.count') do
      post rainworks_url, params: { rainwork: { active: @rainwork.active, approved: @rainwork.approved, creator_email: @rainwork.creator_email, creator_name: @rainwork.creator_name, description: @rainwork.description, image_url: @rainwork.image_url, name: @rainwork.name } }, as: :json
    end

    assert_response 201
  end

  test "should show rainwork" do
    get rainwork_url(@rainwork), as: :json
    assert_response :success
  end

  test "should update rainwork" do
    patch rainwork_url(@rainwork), params: { rainwork: { active: @rainwork.active, approved: @rainwork.approved, creator_email: @rainwork.creator_email, creator_name: @rainwork.creator_name, description: @rainwork.description, image_url: @rainwork.image_url, name: @rainwork.name } }, as: :json
    assert_response 200
  end

  test "should destroy rainwork" do
    assert_difference('Rainwork.count', -1) do
      delete rainwork_url(@rainwork), as: :json
    end

    assert_response 204
  end
end
