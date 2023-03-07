require "test_helper"

class HotspotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hotspot = hotspots(:one)
  end

  test "should get index" do
    get hotspots_url
    assert_response :success
  end

  test "should get new" do
    get new_hotspot_url
    assert_response :success
  end

  test "should create hotspot" do
    assert_difference("Hotspot.count") do
      post hotspots_url, params: { hotspot: { address: @hotspot.address, description: @hotspot.description, hotspot_picture: @hotspot.hotspot_picture, latitude: @hotspot.latitude, longitude: @hotspot.longitude, name: @hotspot.name } }
    end

    assert_redirected_to hotspot_url(Hotspot.last)
  end

  test "should show hotspot" do
    get hotspot_url(@hotspot)
    assert_response :success
  end

  test "should get edit" do
    get edit_hotspot_url(@hotspot)
    assert_response :success
  end

  test "should update hotspot" do
    patch hotspot_url(@hotspot), params: { hotspot: { address: @hotspot.address, description: @hotspot.description, hotspot_picture: @hotspot.hotspot_picture, latitude: @hotspot.latitude, longitude: @hotspot.longitude, name: @hotspot.name } }
    assert_redirected_to hotspot_url(@hotspot)
  end

  test "should destroy hotspot" do
    assert_difference("Hotspot.count", -1) do
      delete hotspot_url(@hotspot)
    end

    assert_redirected_to hotspots_url
  end
end
