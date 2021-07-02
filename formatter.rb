require "terminal-table"

module Formatter
  def print_content(title, headings, collection, &row_formatter)
    table = Terminal::Table.new
    table.title = title
    table.headings = headings
    table.rows = collection.map(&row_formatter)
    puts table
  end

  def print_boards
    print_content("CLIn Boards", %w[ID Name Description List(#cards)], @boards) do |board|
      list_arr = []
      board.lists.each do |list|
        list_arr = []
        list_arr << "#{list.name}(#{list.cards.size})"
      end
      [board.id, board.name, board.description, list_arr.join(", ")]
    end
  end

  def print_lists
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

  def print_card_checklist
    collection = [
      { "title": "Create List class", "checklist": [
        { "title": "Define initialize method", "completed": true },
        { "title": "Add public methods", "completed": false },
        { "title": "Share with the team for feedback", "completed": false }
      ] }
    ]
    puts "Card: #{collection[0][:title]}"

    collection[0][:checklist].each_with_index do |checklist, idx|
      toggle = checklist[:completed] ? "x" : " "
      puts "[#{toggle}] #{idx + 1}. #{checklist[:title]}"
    end

    puts "-------------------------------------"
  end

  def print_lists_names
    list_arr = []
    @lists.each do |list|
      list_arr << list.name
    end
    puts list_arr.join(" | ")
  end
end
