require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test 'should not save task without a category' do
    task = Task.new(task_name: 'Task Name', task_description: 'Task Description')
    assert_not task.valid?, 'Task should be invalid without a category'
    assert_includes task.errors.full_messages, "Category must exist"
  end

  test 'should save task with a category' do
    category = Category.create(categories_name: 'Some Category', description: 'Category description', user_id: 1)
    task = Task.new(task_name: 'Task Name', task_description: 'Task Description', category: category)

    assert task.valid?, 'Task should be valid with a category'
    assert task.save, 'Failed to save task with a category'
    assert_not_nil task.id, 'Task creation failed'
  end
end
