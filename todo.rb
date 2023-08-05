# Class to represent the to-do list
class ToDoList
  def initialize
    @tasks = []
    load_tasks
  end

  def add_task(task)
    @tasks << task
    save_tasks
  end

  def remove_task(task_index)
    if task_index >= 0 && task_index < @tasks.length
      @tasks.delete_at(task_index)
      save_tasks
    else
      puts "Invalid index."
    end
  end

  def complete_task(task_index)
    if task_index >= 0 && task_index < @tasks.length
      @tasks[task_index] = "[Completed] " + @tasks[task_index]
      save_tasks
    else
      puts "Invalid index."
    end
  end

  def display_tasks
    if @tasks.empty?
      puts "No tasks in the list."
    else
      @tasks.each_with_index do |task, index|
        puts "#{index}. #{task}"
      end
    end
  end

  def save_tasks
    File.open("tasks.txt", "w") do |file|
      @tasks.each do |task|
        file.puts(task)
      end
    end
  end

  def load_tasks
    if File.exist?("tasks.txt")
      File.open("tasks.txt", "r") do |file|
        file.each_line do |line|
          @tasks << line.chomp
        end
      end
    end
  end
end

# Main function
def main
  todo_list = ToDoList.new

  loop do
    puts "======= To-Do List ======="
    puts "1. Add task"
    puts "2. Remove task"
    puts "3. Mark task as completed"
    puts "4. Display tasks"
    puts "5. Exit"
    print "Choose an option: "
    choice = gets.chomp.to_i

    case choice
    when 1
      print "Enter the task: "
      task = gets.chomp
      todo_list.add_task(task)
    when 2
      print "Enter the index of the task to remove: "
      index = gets.chomp.to_i
      todo_list.remove_task(index)
    when 3
      print "Enter the index of the completed task: "
      index = gets.chomp.to_i
      todo_list.complete_task(index)
    when 4
      puts "======= Task List ======="
      todo_list.display_tasks
      puts "========================"
    when 5
      puts "Exiting..."
      break
    else
      puts "Invalid option. Please try again."
    end

    puts "\n"
  end
end

# Start the program by calling the main function
main
