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

  def print_lists(board)
    board.lists.each do |list|
      print_content(list.name, %w[ID Title Members Labels Due Date Checklist], list.cards) do |card|
        done = completed_over_total(card)
        [card.id, card.title, card.members.join(", "), card.labels.join(", "), card.due_date, done]
      end
    end
  end

  def completed_over_total(card)
    size = card.checklist.size
    checked = card.checklist.count { |item| item[:completed] }
    "#{checked}/#{size}"
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

  def print_lists_names(board)
    list_arr = []
    board.lists.each do |list|
      list_arr << list.name
    end
    puts list_arr.join(" | ")
  end

  def list_selection_form(options)
    list = ""
    until options.include?(list)
      print "Select a list: "
      list = gets.chomp.downcase
    end
    list
  end
end
