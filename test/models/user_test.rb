require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'should not save user without a unique email' do
    existing_user = User.create(username: 'existing_user', email: 'test@example.com', password: 'password')
    new_user = User.new(username: 'new_user', email: 'test@example.com', password: 'password')

    assert_not new_user.save, 'Saved user with a non-unique email'
    assert_includes new_user.errors.full_messages, 'Email has already been taken'
  end

  test 'should save user with valid attributes' do
    user = User.new(username: 'new_user', email: 'test@example.com', password: 'password')

    assert user.save, 'Failed to save user with valid attributes'
    assert_not_nil user.id, 'User creation failed'
  end

  test 'should not save user without a password' do
    user = User.new(username: 'new_user', email: 'test@example.com')

    assert_not user.save, 'Saved user without a password'
    assert_includes user.errors.full_messages, "Password can't be blank"
  end
end
