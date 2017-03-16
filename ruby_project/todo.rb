# Ruby exercise project https://www.codecademy.com/final_project/ruby
# Notes in file notes.md
# Todo list to manipulate from the command line
# Modules
module Menu
  def menu
    puts "What do you want to do with your Todo list?
     1) Add task
     2) Show tasks
     3) Update task
     4) Delete task
     5) Save to file
     6) Load file
     7) Toggle status
     Q) Quit"
  end

  def show
    menu
  end
end

module Promptable
  def prompt(message = 'What would you like to do?', symbol = ':> ' )
    print message
    print symbol
    gets.chomp
  end
end

# Classes
class List
  attr_reader :all_tasks

  def initialize
    @all_tasks = []
  end

  def add(task)
    all_tasks << task
  end

  def show
    all_tasks.map.with_index {|t, index| "#{index.next}) #{t}" }
  end

  def update (task_number, task)
    all_tasks[task_number -1] = task
  end

  def delete(task_number)
    all_tasks.delete_at(task_number.to_i - 1)
  end

  def toggle(task_number)
	  all_tasks[task_number - 1].toggle_status
	end

  def write_to_file(filename)
    machinified = @all_tasks.map(&:to_machine).join("\n")
    IO.write(filename, machinified)
  end

  def read_file(filename)
    IO.readlines(filename).each do |line|
            status, *description = line.split(':')
            status = status.include?('X')
            add(Task.new(description.join(':').strip, status))
      end
  end
end

class Task
  attr_reader :description
  attr_accessor :status

  def initialize(description, status = false)
    @description = description
    @status = status
  end

  def to_s
    description
  end

  def completed?
    status
  end

  def toggle_status
    @completed_status = !completed?
  end

  def to_machine
      "#{represent_status}:#{description}"
  end

  private

  def represent_status
    completed? ? '[X]' : '[ ]'
  end
end

# Actions
# Program runner
if __FILE__ == $PROGRAM_NAME
  my_list = List.new
  include Menu
  include Promptable
  puts "Please choose from the following list"
    until ['q'].include?(user_input = prompt(show).downcase)
      case user_input
        when "1"
          my_list.add(Task.new(prompt('Task?')))
        when "2"
          puts my_list.show
        when "3"
          puts my_list.show
          my_list.update(prompt("Which task do you want to update?").to_i,
              Task.new(prompt('Task Description?')))
        when "4"
          puts my_list.show
          my_list.delete(prompt("Which task do you want to delete?".to_i))
          puts my_list.show
        when "5"
          my_list.write_to_file(prompt('Name of file to write to?' ))
        when "6"
          begin
            my_list.read_file(prompt('Name of file to load?' ))
          rescue Errno::ENOENT
                  puts 'File name not found, please verify your file name
                  and path.'
          end
        when "7"
          puts my_list.show
          my_list.toggle(prompt('Which would you like to toggle the
          status for?').to_i)
        else
          puts 'Try again, I did not understand.'
        end
      prompt('Press enter to continue', '')
    end
  puts 'Outro - Thanks for using the menu system!'
end


# solution
#
#
#   module Menu
#
#     def menu
#       " Welcome to the TodoLister Program!
#       This menu will help you use the Task List System
#       1) Add
#       2) Show
#       3) Update
#       4) Delete
#       5) Write to File
#       6) Read from File
#       7) Toggle Status
#       Q) Quit "
#     end
#
#     def show
#       menu
#     end
#
#   end
#
#   module Promptable
#
#     def prompt(message = "Just the facts, ma'am.", symbol = ':> ')
#       print message
#       print symbol
#       gets.chomp
#     end
#
#   end
#
#   class List
#     attr_reader :all_tasks
#
#     def initialize
#       @all_tasks = []
#     end
#
#     def add(task)
#       all_tasks << task
#     end
#
#     def delete(task_number)
#       all_tasks.delete_at(task_number - 1)
#     end
#
#     def update(task_number, task)
#       all_tasks[task_number - 1] = task
#     end
#
#     def show
#       all_tasks.map.with_index { |l, i| "(#{i.next}): #{l}" }
#     end
#
#     def write_to_file(filename)
#       machinified = @all_tasks.map(&:to_machine).join("\n")
#       IO.write(filename, machinified)
#     end
#
#     def read_from_file(filename)
#       IO.readlines(filename).each do |line|
#         status, *description = line.split(':')
#         status = status.downcase.include?('x')
#         add(Task.new(description.join(':').strip, status))
#       end
#     end
#
#     def toggle(task_number)
#       all_tasks[task_number - 1].toggle_status
#     end
#
# end
#
#   class Task
#     attr_reader :description
#     attr_accessor :completed_status
#
#     def initialize(description, completed_status = false)
#       @description = description
#       @completed_status = completed_status
#     end
#
#     def to_s
#       "#{represent_status} : #{description}"
#     end
#
#     def completed?
#       completed_status
#     end
#
#     def toggle_status
#       @completed_status = !completed?
#     end
#
#     def to_machine
#       "#{represent_status}:#{description}"
#     end
#
#     private
#
#     def represent_status
#       completed? ? '[X]' : '[ ]'
#     end
#
#   end
#
#
#   if __FILE__ == $PROGRAM_NAME
#     include Promptable
#     include Menu
#     my_list = List.new
#     puts 'Please choose from the following list'
#     until ['q'].include?(user_input = prompt(show).downcase)
#       case user_input
#         when '1'
#           my_list.add(Task.new(prompt('What is the task you
#           would like to accomplish?')))
#         when '2'
#           puts my_list.show
#         when '3'
#           my_list.update(prompt('Which task to update?').to_i,
#           Task.new(prompt('Task Description?')))
#         when '4'
#           puts my_list.show
#           my_list.delete(prompt('Which task to delete?').to_i)
#         when '5'
#           my_list.write_to_file(prompt 'What is the filename to
#           write to?')
#         when '6'
#           begin
#             my_list.read_from_file(prompt('What is the filename to
#             read from?'))
#           rescue Errno::ENOENT
#             puts 'File name not found, please verify your file name
#             and path.'
#           end
#         when '7'
#           puts my_list.show
#           my_list.toggle(prompt('Which would you like to toggle the
#           status for?').to_i)
#         else
#           puts 'Try again, I did not understand.'
#         end
#         prompt('Press enter to continue', '')
#       end
#     puts 'Outro - Thanks for using the menu system!'
#   end
