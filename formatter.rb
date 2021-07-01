require "terminal-table"

module Formatter
  class Test
    def self.print_content(title, headings, collection, &row_formatter)
      table = Terminal::Table.new
      table.title = title
      table.headings = headings
      table.rows = collection.map(&row_formatter)
      puts table
    end
  end
end

title = "CLIn Boards"
headings = %w[ID Name Description List(#cards)]
collection = [
  {
    "id": 1,
    "name": "Extended - CLIn Boards",
    "description": "Task management for the last extended",
    "lists": [0, 1, 2, 3]
  },
  {
    "id": 2,
    "name": "Test - CLIn Boards",
    "description": "May Rubocop have mercy upon us",
    "lists": [0, 1]
  }
]
Formatter::Test.print_content(title, headings, collection) do |board|
  [board[:id], board[:name], board[:description], board[:lists].size]
end
