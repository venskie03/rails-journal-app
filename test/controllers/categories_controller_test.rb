require "test_helper"
require 'bcrypt'
class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    password_digest = BCrypt::Password.create('password')
    @user = User.create(username: 'test_user', email: 'test@example.com', password_digest: password_digest)
    @category = @user.categories.create(categories_name: 'Test Category', description: 'Category Description')
  end
  def sign_in(user)
    post sessions_path, params: { session: { email: user.email, password: 'password' } }
  end

  test 'should not get index when not authenticated' do
    get categories_path
    assert_redirected_to sign_in_path
  end
end
