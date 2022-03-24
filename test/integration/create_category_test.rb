require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and creating the category" do
    #path fot the form
    get "/categories/new"
    #if we successfully visit /categories/new response success
    assert_response :success
    #after filling form check for count difference 1
    assert_difference 'Category.count',1 do
      #post the category sports to the testing database
      post categories_path, params: { category: {name: "Sports"}}
      #redirect (in this case to show page for category)
      assert_response :redirect
    end
    #after redirecting follow the redirect
    follow_redirect!
    assert_response :success
    #the show page for categories will surely display the name(Sports) and we are looking for that
    assert_match "Sports", response.body
  end
end
