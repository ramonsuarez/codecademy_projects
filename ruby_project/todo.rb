# Ruby exercise project https://www.codecademy.com/final_project/ruby
# Notes in file notes.md
# Todo list to manipulate from the command line
#
#Classes
class List
  attr_reader :all_tasks

  def initialize
    @all_tasks = []
  end

  def add(task)
    all_tasks << task
  end

  def show
    all_tasks
  end

end

class Task
  attr_reader :description

  def initialize(description)
    @description = description
  end

end

# actions
# Program runner
if __FILE__ == $PROGRAM_NAME
  my_list = List.new
  puts "You have created a new list"
  my_list.add(Task.new('Make Breakfast'))
  puts 'You have added a task to the Todo list'
  my_list.add(Task.new('Buy milk'))
  puts 'You have added a task to the Todo list'
  my_list.add(Task.new('Pick up dry cleaner'))
  puts 'You have added a task to the Todo list'
  puts my_list.show
end


