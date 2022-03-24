require 'test_helper'



class CategoryTest < ActiveSupport::TestCase

  #each variable is available in the specific test and we can't use it out of the test
  #to use the variables common in all test use setup method

  #this method will run before each test
  def setup
    @category = Category.new(name:"Sports")
  end

  test "categories should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = ""
    #false test (should not be valid)
    assert_not @category.valid?
  end

  test "name should be uniques" do
    @category.save
    @category2=Category.new(name:"Sports")
    assert_not @category2.valid?
  end

  test "name should not be too long" do
    @category.name="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category.name="a"
    assert_not @category.valid?
  end
end
