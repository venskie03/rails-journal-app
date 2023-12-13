require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  test 'should save category with valid attributes' do
    user = User.create(username: 'test_user', email: 'test@example.com', password: 'password')
    category = user.categories.new(categories_name: 'Test Category', description: 'Category Description')

    assert category.save, 'Failed to save category with valid attributes'
    assert_not_nil category.id, 'Category creation failed'
  end

  test 'should not save category without a name' do
    user = User.create(username: 'test_user', email: 'test@example.com', password: 'password')
    category = user.categories.new(description: 'Category Description')

    assert_not category.save, 'Saved category without a name'
    assert_includes category.errors.full_messages, "Categories name can't be blank"
  end

  test 'should not save category without a description' do
    user = User.create(username: 'test_user', email: 'test@example.com', password: 'password')
    category = user.categories.new(categories_name: 'Test Category')

    assert_not category.save, 'Saved category without a description'
    assert_includes category.errors.full_messages, "Description can't be blank"
  end
end
