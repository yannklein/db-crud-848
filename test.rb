require "sqlite3"
require "pry-byebug"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative "task"

# Implement the READ logic to find a given task (by its id)
id = 1
p Task.find(id)
# Implement the CREATE logic in a save instance method
task = Task.new(title: "Hi!", description: "Say hi to Louis!")
# task.save
# Implement the UPDATE logic in the same method
task = Task.find(2)
task.done = true
# task.save
# Implement the READ logic to retrieve all tasks (what type of method is it?)
p Task.all
# Implement the DESTROY logic on a task
first_task = Task.find(1)
first_task.destroy
p Task.all