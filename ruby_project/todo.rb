# Ruby exercise project https://www.codecademy.com/final_project/ruby
# Notes in file notes.md
# Todo list to manipulate from the command line
# Modules
module Menu
  def menu
    puts "What do you want to do with your Todo list?
     1) Add task
     2) Show tasks
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
    all_tasks
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
        else
          puts "Not one of my options, try again."
      end
      prompt('Press enter to continue', '')
    end
    puts 'Outro - Thanks for using the menu system!'
end
