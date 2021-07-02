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
    @lists.each do |list|
      print_content(list.name, %w[ID Title Members Labels Due Date Checklist], list.cards) do |card|
        size = card.checklist.size
        checked = card.checklist.count { |item| item[:completed] }
        [card.id, card.title, card.members.join(", "), card.labels.join(", "), card.due_date, "#{checked}/#{size}"]
      end
    end
  end

  def print_card_checklist
    puts "Card: #{@title}"

    @checklist.each_with_index do |item, idx|
      toggle = item[:completed] ? "x" : " "
      puts "[#{toggle}] #{idx + 1}. #{item[:title]}"
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
