require "json"
require_relative "boards"

class Store
  attr_accessor :boards

  def initialize(filename)
    @filename = filename
    @boards = load_boards
  end

  def load_boards
    JSON.parse(File.read(@filename), { symbolize_names: true }).map do |board|
      Boards.new(board)
    end
  end

  def add_board(board)
    @boards << board
    # File.write(@filename, @boards.to_json)
  end

  def find_card(card_id)
    list_selected = @boards.lists.select do |list|
      list.cards.find { |card| card.id == card_id }
    end

    list_selected.cards.find { |card| card.id == card_id }
  end

  def add_checklist(card, checklist)
    card.checklist << checklist
    persist_json
  end

  def toggle_checklist(card, index)
    checklist = card.checklist[index]
    checklist[:completed] = !checklist[:completed]
    persist_json
  end
end
