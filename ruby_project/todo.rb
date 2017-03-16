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

  def write_to_file(filename)
    IO.write(filename, @all_tasks.map(&:to_s).join("\n"))
  end

  def read_file(filename)
    IO.readlines(filename).each {|l| add(Task.new(l.chomp)) }
  end
end

class Task
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def to_s
    description
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

        when "4"
          puts my_list.show
          my_list.delete(prompt("Which task do you want to delete?".to_i))
        when "5"
          my_list.write_to_file(prompt('Name of file to write to?' ))
        when "6"
          begin
            my_list.read_file(prompt('Name of file to load?' ))
          rescue Errno::ENOENT
                  puts 'File name not found, please verify your file name
                  and path.'
          when "7"

          end
        else
          puts "Not one of my options, try again."
      end
      prompt('Press enter to continue', '')
    end
    puts 'Outro - Thanks for using the menu system!'
end
