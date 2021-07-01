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
      print_content("CLIn Boards", %w[ID Name Description List(#cards)], collection) do |board|
        [board[:id], board[:name], board[:description], "List(#{board[:lists].size})"] # HARDCODE!!!
      end
    end

    def self.print_lists
      collection = [ # HARDCODE!!!
        { "id": 1, "name": "Todos", "cards": [
          {
            "id": 8, "title": "Do something nice", "members": %w[Ana Andres Luis],
            "labels": ["project"], "due_date": "2021-06-03", "checklist": []
          }
        ] },
        { "id": 2, "name": "In Progress", "cards": [
          {
            "id": 4, "title": "Create List class", "members": ["Deyvi"],
            "labels": %w[coding challenge], "due_date": "2020-11-19", "checklist": []
          }
        ] }
      ]
      collection.each do |list|
        print_content(list[:name], %w[ID Title Members Labels Due Date Checklist], list[:cards]) do |c|
          [c[:id], c[:title], c[:members].join(", "), c[:labels].join(", "), c[:due_date], c[:checklist]]
        end
      end
    end
  end
end

Formatter::Test.print_boards
Formatter::Test.print_lists
