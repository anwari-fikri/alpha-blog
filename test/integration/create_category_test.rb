require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = User.create(username: "admin", email: "admin@alphablog.com", password: "password", admin: true)
  end

  test "get new category form and create category as an admin" do
    sign_in_as(@admin_user)
    get "/categories/new"
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_path, params: { category: { name: "Sports" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "get new category form and reject invalid category submission as an admin" do
    sign_in_as(@admin_user)
    get "/categories/new"
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "" } }
    end
    assert_match "Name is too short (minimum is 3 characters)", response.body
  end
end
