require "test_helper"
require 'bcrypt'
class TaskControllerTest < ActionDispatch::IntegrationTest
  def sign_in(user)
    post sessions_path, params: { session: { email: user.email, password: 'password' } }
  end

  setup do
    password_digest = BCrypt::Password.create('password')
    @user = User.create(username: 'test_user', email: 'test@example.com', password_digest: password_digest)
    @category = @user.categories.create(categories_name: 'Test Category', description: 'Category Description')
    @task = @category.tasks.create(task_name: "Test Task", task_description: "Task Description", task_date: DateTime.now, category_id: "1")
    sign_in @user
  end
  test "should redirect to login if not signed in" do
    get category_tasks_path(@category)
    assert_response :redirect
    assert_redirected_to sign_in_path
  end

  test "should get index" do
    sign_in @user
    get category_tasks_path(@category)
   end
   
   test "task_name should not be empty" do
   @task = @category.tasks.create( task_name: "Shesh", task_description: "Task Description", task_date: DateTime.now, category_id: "1")
  end

end
