require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  fixtures :categories
  
  test "invalid when new" do
    category = Category.new

    assert category.invalid?
  end
  
  test "invalid name when new" do
    category = Category.new

		category.save
    assert category.errors.invalid?(:name)
  end  

  test "unique name within parent category is accepted" do
    category = Category.new(:id => 102, :parent_id => 101, :name => 'myName')

    assert category.valid?, category.errors.full_messages.to_s
  end

  test "existing name within parent category is rejected" do
    category = Category.new(:id => 102, :parent_id => 101, :name => 'Flying Eagle') #exists

    assert category.invalid?
    assert category.errors.invalid?(:name)
  end

  test "cannot be own parent" do
    category = Category.new(:id => 102, :parent_id => 102, :name => 'New Cat') #self parent
    
    assert !category.save
  end

  test "cannot add a nonexistent parent" do
    category = Category.new(:id => 101, :parent_id => 110, :name => 'New Cat')

    assert category.invalid?
  end
end
