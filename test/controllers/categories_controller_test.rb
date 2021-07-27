require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")
    @user = User.create(username: "user", email: "user@gmail.com", password: "password")
    @admin_user = User.create(username: "admin", email: "admin@alphablog.com", password: "password", admin: true)
  end

  #index

  test "when not logged in, redirect to login page when accessing index" do
    get categories_url

    assert_redirected_to login_path
  end

  test "when logged in as user, get index when accessing index" do
    sign_in_as(@user)

    get categories_url

    assert_response :success
  end

  test "when logged in as admin, get index when accessing index" do
    sign_in_as(@admin_user)

    get categories_url
    
    assert_response :success
  end


  #new

  test "when not logged in, show permission error when accessing new" do
    get new_category_url

    assert_match "[categories] wait... that's illegal. Only admin can do that.", response.body, "Given text to match is not found in the body"
  end

  test "when logged in as admin, show permission error when accessing new" do
    sign_in_as(@user)

    get new_category_url

    assert_match "[categories] wait... that's illegal. Only admin can do that.", response.body, "Given text to match is not found in the body"
  end

  test "when logged in as admin, get new when accessing new" do
    sign_in_as(@user)

    get new_category_url

    assert_response :success, "response does not land on expected page"
  end


  #create

  test "should create category" do
    sign_in_as(@admin_user)
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: "Travel" } }
    end

    assert_redirected_to category_url(Category.last)
  end
  
  test "should not create category if not admin" do
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: "Travel" } }
    end

    assert_match "wait... that's illegal", response.body
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end
