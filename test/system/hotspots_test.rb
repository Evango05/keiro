require "application_system_test_case"

class HotspotsTest < ApplicationSystemTestCase
  setup do
    @hotspot = hotspots(:one)
  end

  test "visiting the index" do
    visit hotspots_url
    assert_selector "h1", text: "Hotspots"
  end

  test "should create hotspot" do
    visit hotspots_url
    click_on "New hotspot"

    fill_in "Address", with: @hotspot.address
    fill_in "Description", with: @hotspot.description
    fill_in "Hotspot picture", with: @hotspot.hotspot_picture
    fill_in "Latitude", with: @hotspot.latitude
    fill_in "Longitude", with: @hotspot.longitude
    fill_in "Name", with: @hotspot.name
    click_on "Create Hotspot"

    assert_text "Hotspot was successfully created"
    click_on "Back"
  end

  test "should update Hotspot" do
    visit hotspot_url(@hotspot)
    click_on "Edit this hotspot", match: :first

    fill_in "Address", with: @hotspot.address
    fill_in "Description", with: @hotspot.description
    fill_in "Hotspot picture", with: @hotspot.hotspot_picture
    fill_in "Latitude", with: @hotspot.latitude
    fill_in "Longitude", with: @hotspot.longitude
    fill_in "Name", with: @hotspot.name
    click_on "Update Hotspot"

    assert_text "Hotspot was successfully updated"
    click_on "Back"
  end

  test "should destroy Hotspot" do
    visit hotspot_url(@hotspot)
    click_on "Destroy this hotspot", match: :first

    assert_text "Hotspot was successfully destroyed"
  end
end
