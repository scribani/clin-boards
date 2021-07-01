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

    def self.print_boards
      collection = [ # HARDCODE!!!
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
      print_content("CLIn Boards", %w[ID Name Description List(#cards)], collection) do |board| # HARDCODE!!!
        [board[:id], board[:name], board[:description], "List(#{board[:lists].size})"] # HARDCODE!!!
      end
    end
  end
end

Formatter::Test.print_boards
