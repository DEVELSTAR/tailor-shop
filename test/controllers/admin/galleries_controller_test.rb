require "test_helper"

class Admin::GalleriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_galleries_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_galleries_show_url
    assert_response :success
  end

  test "should get new" do
    get admin_galleries_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_galleries_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_galleries_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_galleries_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_galleries_destroy_url
    assert_response :success
  end
end
