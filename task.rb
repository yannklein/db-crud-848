class Task
  attr_reader :id
  attr_accessor :title, :description, :done
  def initialize( attributes = {} )
    @id = attributes[:id] || attributes["id"]
    @title = attributes[:title] || attributes["title"]
    @description = attributes[:description] || attributes["description"]
    @done = (attributes[:done] || attributes["done"]) == 1 || false
  end

  def self.find(id)
    # pseudocode?
    task_hash = DB.execute("SELECT * FROM tasks WHERE id = ?", id).first
    return nil if task_hash.nil?

    Task.new(task_hash)
  end

  def save
    if @id.nil?
      DB.execute("INSERT INTO tasks (title, description, done) VALUES (?,?,?)", @title, @description, @done ? 1 : 0)
      @id = DB.last_insert_row_id
    else
      DB.execute("UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?", @title, @description, @done ? 1 : 0, @id)
    end
  end

  def self.all
    all_tasks = DB.execute("SELECT * FROM tasks")
    all_tasks.map do |task| 
      Task.new(task)
    end
  end

  def destroy
    query = "DELETE FROM tasks WHERE id = ?"
    DB.execute(query, @id)
  end
end