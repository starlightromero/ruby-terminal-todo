puts "Welcome to Ruby Terminal Todo"
puts "============================="

def prompt_user(todos)
  puts "0. Add a task"
  if todos.length() > 0
    for i in 0..(todos.length() - 1)
      puts ((i + 1).to_s + ". " + todos[i])
    end
  end
  puts "q. Quit"
  print "What would you like to do? "
  user_input = gets.chomp().downcase()
end

def get_todos
  todos = nil
  File.open("todos.txt", "r") do |file|
     todos = file.read().split(",")
  end
  todos
end

def save_todos(todos)
  File.open("todos.txt", "w") do |file|
    file.write(todos.join(","))
  end
end

todos = get_todos
user_input = prompt_user(todos)

while user_input != "q"
  if user_input == "0"
    print "Enter a task: "
    new_task = gets.chomp()
    new_task.prepend("[] ")
    todos.append(new_task)
  else
    begin
      index = user_input.to_i - 1
      if index >= 0
        todo = todos[index]
        todo["[]"] = "[x]"
      end
    rescue IndexError
      puts "The todo has already been completed"
      print "Would you like to delete the todo? (y/n) "
      delete_confirmation = gets
      if delete_confirmation.chomp().downcase()[0] == "y"
        todos.delete_at(index)
      end
    rescue NoMethodError
      puts "Please enter a valid option"
    end
  end
  
  save_todos(todos)
  
  puts "============================="
  user_input = prompt_user(todos)
end