require "rspec/mocks"

# This is a stub you can use in your tests that has the
# same interface as the original executor
module ExecutorDouble
  def executor_double
    executor = double
    executor.stub(:start_section)
    executor.stub(:start_task)
    executor.stub(:task_succeeded)
    executor.stub(:task_failed)
    executor.stub(:skip_task)
    executor.stub(:info)
    executor.stub(:create_path_in_home)
    executor.stub(:get_path_in_home)
    executor.stub(:execute)
    executor.stub(:execute_interactive)
    executor
  end
end
